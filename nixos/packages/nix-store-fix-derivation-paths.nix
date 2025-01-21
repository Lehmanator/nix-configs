{
  lib
, stdenv
, sqlite
, xargs
, writeShellApplication
, ...
}:
# https://darmstadt.social/@Atemu/113648762806127783
# ```sh
# sqlite3 /nix/var/nix/db/db.sqlite \
#   "SELECT path from ValidPaths where path like '%.drv';" \
#   | xargs -P 32 -I {} \
#       sh -c '[ -e "{}" ] || nix store delete --derivation "{}^*"'
# ```
#
# ```sh
# sudo sqlite3 /nix/var/nix/db/db.sqlite \
#   "DELETE FROM ValidPaths where path='/nix/store/2rknp39lfg5361lwx1a5lsbm89c0jf23-infer-license-0.2.0.drv';"
# ```
writeShellApplication {
  name = "nix-store-fix-database-missing-derivation-paths";
  runtimeInputs = [ sqlite xargs ];
  text = ''
    sqlite3 /nix/var/nix/db/db.sqlite \
      "SELECT path from ValidPaths where path like '%.drv';" \
      | xargs -P 32 -I {} \
          sh -c '[ -e "{}" ] || nix store delete --derivation "{}^*"'
  '';
}

# -  '/nix/store/2rknp39lfg5361lwx1a5lsbm89c0jf23-infer-license-0.2.0.drv'
# - '/nix/store/pbww5x2pgkvfr6cf768vkl3ldgcwlvyi-text-metrics-0.3.2.tar.gz.drv'
# '/nix/store/pm64ryriv6620zhx16a663rxswh5b19z-bash52-024.drv'
# '/nix/store/ps9im73fzk6v9yp669wqlbcvn0fdq8cf-monad-par-0.3.6-r1.cabal.drv'
# '/nix/store/pvc03dvmmfaiymnsggy3vq6r3v6i50c2-fontools.doc.r69241.tar.xz.drv'
# '/nix/store/q1vh3yxssnjshpn04hmsz7whlgwviciz-source.drv'
# '/nix/store/q2n2r3ppyxszsi84zhx110i662lciy0n-python-remove-bin-bytecode-hook.drv'
# '/nix/store/q65178lvlamzsnhgwzrwfda44k8dn2ir-arm-r1.patch?id=1d1de341e1404a46b15ae3e84bc400d474cf1a2c.drv'
# '/nix/store/qb06wvcc88bjmdggdsg9nmv702q5lix0-crate-enumflags2-0.7.5.tar.gz.drv'
# '/nix/store/qbrpnwm4045xf1rfl7dm1bqnrd8fds7k-latex-papersize-1.63.drv'
# '/nix/store/qc3ywdqsh5v34slwh06mwlpgcrz3n319-eglexternalplatform-1.1.drv'
# '/nix/store/qg8ha3fgcl9ci1fmy59f9rkw1hrsb2pf-gn-unstable-2024-03-14.drv'
# '/nix/store/qlf1y8jmy67fb9xg4rw7dagwhgdzqhfm-bootstrap_cmds-121.tar.gz.drv'
# '/nix/store/qq5jmq1y28qfxlfzvbkqvc5vi1xnbs8n-source.drv'
# '/nix/store/qxagw9wshh0cn8s6wygzpz9g4x8n2jyd-python3.11-colour-0.1.5.drv'
# '/nix/store/qzjsrn2zlrxar1qsz2j9dfw98d9dbly1-jira-wiki-markup-1.5.1.tar.gz.drv'
# '/nix/store/r13l62hplnhi449w29g10kns2hi0qq64-crate-realfft-3.3.0.tar.gz.drv'
# '/nix/store/r4s7scnblj2l6pjiss8k8i00al75nksr-source.drv'
# '/nix/store/r68mc8za3w0lvxw6xz518arfxppk0qin-crate-crc-catalog-2.2.0.tar.gz.drv'
# '/nix/store/r7zacr3my59kwpcj8af7qdqq9mjvijl9-colorprofiles-20181105-tex.drv'
# '/nix/store/rv1g4xcrz3g6kicqp6h4xcfz4z4my86r-source.drv'
# '/nix/store/rzrax5km8z9pcqgpwxqrs8i9b4q6ivca-silently-1.2.5.3.tar.gz.drv'
# '/nix/store/s0gc0x6y7qim7493rj2v71ih79d85km4-home-0.5.9.drv'
# '/nix/store/s29wcvk30dg2vphm0y98dgpqyy5j1yvd-hoon-grammar-0.0.0+rev=a24c5a3.drv'
# '/nix/store/s5dvqliwi70swnqgrs2ssg5ynbcsx1mi-System.Net.WebHeaderCollection.4.3.0.nupkg.drv'
# '/nix/store/sa8nwiqy03gniq38sbrl2vm9v6s1r8bp-aalib-1.4rc5.tar.gz.drv'
# '/nix/store/samkvswrvnhpc7j17z86bgxspy2pxznd-stb.pc.drv'
# '/nix/store/sf3lcs63x3g0rasxamnrg6yzpkc5ffp0-jsonfile-1.0.1.tgz.drv'
# '/nix/store/sih6lh1x4g63fws4ilbl1cps0a4qilcl-bangla-0.0.2.tar.gz.drv'
# '/nix/store/sj5im4jdgxkygmgh8b177rp1f0jwydk9-bash52-003.drv'
# '/nix/store/sw0lihlhljqmym796vx81xryigx6xj12-text-metrics-0.3.2.drv'
# '/nix/store/sxxrw3935cig04jj86s5mx51d8n299rl-gcc-12.4.0.drv'
# '/nix/store/v1m8rmq62hw83q0185a2rfza22m0yxwx-fontools-69241-texdoc.drv'
# '/nix/store/vf3138mcg777890j88b6z07xhhm7fwvb-tzdata-2023c.drv'
# '/nix/store/vhvr24vs1df159xqkag6xvf1l62smlxd-conduit-zstd-0.0.2.0.tar.gz.drv'
# '/nix/store/vjswwrxh0k8h4hj6nqywpn650nadm2bb-crate-virtio-queue-0.11.0.tar.gz.drv'
# '/nix/store/vl7nx7ssw5wzawv785j7780v5xc3yx62-tracy-client-0.16.1.drv'
# '/nix/store/vlw54np95059dpsvyqrk3mwfmy27ph5k-schema-0.7.5.tar.gz.drv'
# '/nix/store/vsjdypfm0jw0z605h3i523l1s1jpvw79-source.drv'
# '/nix/store/vv833gyvinrgp46pqf7hdda6vnx7dmkb-execnet-2.0.2.tar.gz.drv'
# '/nix/store/vvzx52bclb6xl153vdqvy7fv26pwkpci-minim.r70320.tar.xz.drv'
# '/nix/store/vzi7l1n7v8yh9p9rm2x42qs9jymyr326-pymanifest-grammar-0.0.0+rev=e3b82b7.drv'
# '/nix/store/w0y71gfg7imxqij1li3azq379pcaks2v-source.drv'
# '/nix/store/w5hlfw8jx0pkcqvx19mcm01j31bn2v4a-perl5.38.2-HTML-Tagset-3.20.drv'
# '/nix/store/w630l87iy6bg8s11jjfbfl2c1rkziz9d-crate-primeorder-0.13.2.tar.gz.drv'
# '/nix/store/w7l2vxwfjwxims2a76l8r0lqq0ivvdkw-cartonaugh.r59938.tar.xz.drv'
# '/nix/store/w9jxdrjdqny349267d64kkf5kpcpk8r3-sistyle-2.3a-tex.drv'
# '/nix/store/wd5li1makmx4xgbp0v7h1qxchllwwz6x-concrete-57963-tex.drv'
# '/nix/store/whlsc0a04hmyx3yr33ki1i8f3m4agb2w-http-client-0.7.17.tar.gz.drv'
# '/nix/store/wjd2wgvlxwmsv35pib3v0g1r384d08xm-bumpalo-3.13.0.drv'
# '/nix/store/wqvdjr62k05ja37d143rxr0kxgpkzh65-no-std-net-0.6.0.drv'
# '/nix/store/wqvijwywmvj0j1an4k0qgvk06djydj25-gnome-weather-45.0.tar.xz.drv'
# '/nix/store/wsav1xm1snd4hs0q98yjafbada0svxay-luafindfont-0.13-texdoc.drv'
# '/nix/store/x047qscc001bjglzazjiff6gv2bvzxxn-bash52-010.drv'
# '/nix/store/x3aysrcrq8rpbswp7y2k6rrvx3ik2bv6-binary-orphans-1.0.4.1.tar.gz.drv'
# '/nix/store/x658x63r3cr8kw0wzq2kwq4y4dpyia79-xcb-util-renderutil-0.3.10.tar.xz.drv'
# '/nix/store/x8gjx7l0rrqj5v5prz3fwyfj6imd3bsx-unliftio-0.2.25.0.tar.gz.drv'
# '/nix/store/x9gv04dvimkpdw3b2rdq97ihn49985q2-python3.11-argon2-cffi-23.1.0.drv'
# '/nix/store/xakzmjla1mh1652rwg0lq3jx56wwgnrn-unix-time-0.4.12.tar.gz.drv'
# '/nix/store/xfk6ch5w3jhwvjgr7vjcb2wzs9v8sx0h-libnfnetlink-1.0.2.drv'
# '/nix/store/xgwrdw89dsf3myd51r3wncz2b23flfqm-ndk-0.8.0.drv'
# '/nix/store/xrfnfn8agilfrnanjvbz567q8dl9ir8z-crate-bumpalo-3.13.0.tar.gz.drv'
# '/nix/store/xsw9q117dg6sgbg0v102gd4r363r6cxb-bash52-009.drv'
# '/nix/store/xwmd6shrvr0pd2yq1nljsmv5hj84mva1-crate-tract-onnx-0.19.16.tar.gz.drv'
# '/nix/store/xyk077lx1rp4psq8a6yg0qcbg659k2i2-source.drv'
# '/nix/store/y1vq8rxr9h0md58n21v2akj2np7mqi0h-libXfont-1.5.4.tar.bz2.drv'
# '/nix/store/ychj2nw5v0bz69rcwh6cjf8rx91vxy5p-source.drv'
# '/nix/store/ycifg1h2z0mhr0x5njkwycir2svw5sd5-source.drv'
# '/nix/store/yf7a6p0xsxf2izdzg5nddfjbl9czpw9s-lua-language-server-3.8.3.drv'
# '/nix/store/yfcycdd6sfajy2xmf6y6lzb722byfv39-parse-latin-5.0.1.tgz.drv'
# '/nix/store/yjqvhv6lqvlsrxnrr99309j79ic33z9w-crate-numeric-sort-0.1.1.tar.gz.drv'
# '/nix/store/ylrvywnv68rli5r2v9xdpnjdnchr3fj5-last_commit_position.h.drv'
# '/nix/store/ywg820v5zwpjp5k34xzlxzq07rjcvnlx-config.sub-28ea239.drv'
# '/nix/store/yx01c8x8xc55k12zq278xgspp5k6vppf-nbformat-5.10.4.tar.gz.drv'
# '/nix/store/yx22z3flhyh1kxpd00s7hkb1yzpsix0h-crate-scroll-0.11.0.tar.gz.drv'
# '/nix/store/yzqlxh7pnsnibh3canmnmlzxcmj8xdgd-python3.11-unicodedata2-15.1.0.drv'
# '/nix/store/z011bk709lc3xqjcmadwcg21f5h91i09-source.drv'
# '/nix/store/z65cyybg5anrj375d650ck68xbqdmn8f-gcc-12.patch.drv'
# '/nix/store/z7pis3g8ap48njp2wxr8f9ilkia4ppz5-unliftio-core-0.2.1.0.tar.gz.drv'
# '/nix/store/z815pvlfpiq9d7wwacfv9kryqal1213z-redent-4.0.0.tgz.drv'
# '/nix/store/zbnyrvr5q45gi8x9z05an67by2njs6y7-abstractions-nss-systemd.drv'
# '/nix/store/zc39l8fh7b0wy5a3kf6013vq4yrw79vm-foldable1-classes-compat-0.1.tar.gz.drv'
# '/nix/store/zh65pr9nvlyn1fbqmfnkfb93h9mq8gdy-gnu-config-2023-09-19.drv'
# '/nix/store/zj7yh6nrpvl0naqhdf0rklmr9icnkf88-fix-youtube-dl-speed.patch.drv'
# '/nix/store/zpa477kfxyqhr2ywrs4al989p0yyzsp8-jam-2.6.1.drv'
# '/nix/store/zvz454mvarixy85my5ghy7vhdlff4rnl-sasnrdisplay-0.95-tex.drv'


