{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonApplication rec {
  pname = "mitsugen";
  version = "main";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "DimitrisMilonopoulos";
    repo = "mitsugen";
    rev = version;
    hash = "sha256-MxUkbsWUIpJoTf4GiXpcoS+rJP34AJT5F5NphiV6LSI=";
  };

  nativeBuildInputs = [
    python3.pkgs.poetry-core
  ];

  propagatedBuildInputs = with python3.pkgs; [
    material
    numpy
    pillow
    pydantic
    pygobject
    regex
    rich
  ];

  pythonImportsCheck = [ "mitsugen" ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/DimitrisMilonopoulos/mitsugen";
    license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
    mainProgram = "mitsugen";
  };
}
