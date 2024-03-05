{ buildEnv
, figlet
, gitAndTools
, man
, nixos-install-tools
, nixos-rebuild
, nixUnstable
, openssh
, writeShellApplication
, lib
, inputs

, config
, ...
}:
# TODO: Allow previewing/adding config from command: nixos-generate-config
# TODO: Set SSH keys for `nixos` user? or disable `nixos` user & use main system user?
writeShellApplication {
  name = "installation-script";

  runtimeInputs = [
    gitAndTools.gitFull
    figlet
    man
    nixUnstable
    nixos-install-tools
    nixos-rebuild
    openssh
  ];

  text = let
    git = lib.getExe gitAndTools.gitFull;
    nix = lib.getExe nixUnstable;
    ssh-keygen = "${openssh}/bin/ssh-keygen";

    # --- Options ---
    repo = {
      host-user = "git";
      host = "github.com";
      owner = "lehmanator";
      repo = "nix-configs";
      branch = "main";

      # TODO: Add git auth SSH keys to installation environment.
      isPrivate = false;
    };

    dirs = {
      base = "/mnt";
      state = "/persist";
    };

    hostname = "";

    # --- Helpers ---
    repo = "${repo.host-user}@${repo.host}:${repo.owner}/${repo.repo}.git";
    cfg-test = o: "${nix} eval " + "${dirs.base}/etc/nixos#nixosConfigurations.${hostname}.config.${o}";
  in ''
    set -euxo pipefail
    export SYSTEM_CLOSURE='${config.system.build.installClosure}'
    export INSTALL_HOSTNAME='${config.system.build.installHostname}'
    BRANCH="''${GIT_REPO_BRANCH:-${repo.branch}}"

    # Allow defining extra script which is called in the install process
    which lehmanator-prepare &>/dev/null && {
      echo 'Running prepare function...'
      lehmanator-prepare && echo 'Prepared.' || echo 'Prepare function failed.'
    }

    # TODO: Ask user if they want to provide a disko config.
    ${config.system.build.installDiskoScript or "echo 'INFO: No disko config provided. Not partitioning automatically.'"}

    # Copy self (flake) to /mnt/etc/nixos
    echo "Copying flake to ${dirs.base}/etc/nixos..."
    mkdir -p ${dir-base}/etc
    cp -rT ${inputs.self} ${dirs.base}/etc/nixos
    echo "Copied flake to ${dirs.base}/etc/nixos."

    echo "Setting up git repo..."
    ${git} -C ${dir-base}/etc/nixos init
    ${git} -C ${dir-base}/etc/nixos remote add origin ${repo}
    (
      ${git} -C ${dir-base}/etc/nixos fetch && \
      ${git} -C ${dir-base}/etc/nixos reset ${inputs.self.rev or "origin/HEAD"} && \
      ${git} -C ${dir-base}/etc/nixos branch --set-upstream-to="origin/${repo.branch}" "${repo.branch}"
    ) || true
    echo "Set up git repo."

    if ${cfg-test "environment.persistence.${dirs.state}"} >/dev/null; then
      mkdir -p ${dirs.base}/etc/ssh
      echo "Please enter the SSH RSA host key for ${hostname} and then press CTRL-D:"
      cat >${dirs.base}/etc/ssh/ssh_host_rsa_key
      chmod u=rw,go= ${dirs.base}/etc/ssh/ssh_host_rsa_key
      ${ssh-keygen} -y -f ${dirs.base}/etc/ssh/ssh_host_rsa_key >${dirs.base}/etc/ssh/ssh_host_rsa_key.pub

      echo "Please enter the SSH ed25519 host key for ${hostname} and then press CTRL-D:"
      cat >${dirs.base}/etc/ssh/ssh_host_ed25519_key
      chmod u=rw,go= ${dirs.base}/etc/ssh/ssh_host_ed25519_key
      ${ssh-keygen} -y -f ${dirs.base}/etc/ssh/ssh_host_ed25519_key >${dirs.base}/etc/ssh/ssh_host_ed25519_key.pub
    fi

    if ${cfg-test "sops.secrets"} >/dev/null; then
      mkdir -p ${dirs.base}${dirs.state}/etc
      cp -a ${dirs.base}/etc/nixos ${dirs.base}${dirs.state}/etc/
      if [ -e ${dirs.base}/etc/ssh ]; then
        mkdir -p ${dirs.base}${dirs.state}/etc/ssh
        cp -a ${dirs.base}/etc/ssh/ssh_host_{rsa,ed25519}_key{,.pub} ${dirs.base}${dirs.state}/etc/ssh/
      fi
    fi

    installArgs=(--no-channel-copy)
    if [ "$(${cfg-test-cmd "users.mutableUsers"})" = "false" ]; then
      installArgs+=(--no-root-password)
    fi

    nixos-install --flake "${dir-base}/etc/nixos#${hostname}" "''${installArgs[@]}"
  '';

}
