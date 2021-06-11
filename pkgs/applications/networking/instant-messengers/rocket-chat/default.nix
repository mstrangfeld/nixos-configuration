{ stdenv
, lib
, fetchurl
, dpkg
, libnotify
, gtk3
, nss
, libXScrnSaver
, libXtst
, xdg-utils
, at-spi2-core
, libuuid
, libappindicator-gtk3
, libsecret
, autoPatchelfHook
}:
let
  binaryName = "rocketchat-desktop";
in
stdenv.mkDerivation rec {
  pname = "rocket-chat";
  version = "3.2.2";

  src = fetchurl {
    url = "https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/${version}/rocketchat_${version}_amd64.deb";
    sha256 = lib.fakeSha256;
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
  ];

  buildInputs = [
    libnotify # libnotify4
    gtk3 # libgtk-3-0
    nss # libnss3
    libXScrnSaver # libxss1
    libXtst # libxtst6
    xdg-utils # xdg-utils
    at-spi2-core # libatspi2.0-0
    libuuid # libuuid1
    libappindicator-gtk3 # libappindicator3-1
    libsecret # libsecret-1-0
  ];

  unpackPhase = ''
    ${dpkg}/bin/dpkg-deb -x $src .
  '';

  installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    ln -s $out/opt/Rocket.Chat/rocketchat-desktop $out/bin/
  '';

  meta = with lib; {
    homepage = "https://rocket.chat";
    description = "Official Desktop Client for Rocket.Chat";
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
