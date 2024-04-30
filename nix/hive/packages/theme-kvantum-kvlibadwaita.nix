{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "kv-libadwaita";
  version = "unstable-2024-01-08";

  src = fetchFromGitHub {
    owner = "GabePoel";
    repo = "KvLibadwaita";
    rev = "06d9a42c6876d1483fda178cd2a672861e424fa6";
    hash = "sha256-dz7xotlh/Yxryl0CCa0AF8VK7tgO/Nqw57qErk5cM3I=";
  };

  meta = with lib; {
    description = "Libadwaita style theme for Kvantum. Based on Colloid-kde";
    homepage = "https://github.com/GabePoel/KvLibadwaita";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "kv-libadwaita";
    platforms = platforms.all;
  };
}
