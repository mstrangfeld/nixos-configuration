{ lib
, stdenv
, fetchurl
, dpkg
, alsa-lib
, atk
, cairo
, cups
, curl
, dbus
, expat
, fontconfig
, freetype
, gdk-pixbuf
, glib
, glibc
, gnome2
, gnome
, gtk3
, libappindicator-gtk3
, libnotify
, libpulseaudio
, libsecret
, libv4l
, nspr
, nss
, pango
, systemd
, wrapGAppsHook
, xorg
, at-spi2-atk
, libuuid
, at-spi2-core
, libdrm
, mesa
, libxkbcommon
}:
let
  binaryName = "rocketchat-desktop";
  rpath = lib.makeLibraryPath [
    alsa-lib
    atk
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    curl
    dbus
    expat
    fontconfig
    freetype
    glib
    glibc
    libsecret
    libuuid

    gnome2.GConf
    gdk-pixbuf
    gtk3
    libappindicator-gtk3

    gnome.gnome-keyring

    libnotify
    libpulseaudio
    nspr
    nss
    pango
    stdenv.cc.cc
    systemd

    libv4l
    libdrm
    mesa
    libxkbcommon
    xorg.libxkbfile
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libXScrnSaver
    xorg.libxcb
  ] + ":${stdenv.cc.cc.lib}/lib64";
in
stdenv.mkDerivation rec {
  pname = "rocket-chat";
  version = "3.2.2";

  src = fetchurl {
    url = "https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/${version}/rocketchat_${version}_amd64.deb";
    sha256 = "sha256-20snwTx0tVr1sxmG9ba47iwKcXZBgYn+sTmW8B4v7rA=";
  };

  nativeBuildInputs = [
    wrapGAppsHook
    glib
  ];

  buildInputs = [ dpkg ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    mkdir -p $out/bin
    ln -s $out/opt/Rocket.Chat/rocketchat-desktop $out/bin/
  '';

  postFixup = ''
    for file in $(find $out -type f \( -perm /0111 -o -name \*.so\* -or -name \*.node\* \) ); do
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$file" || true
      patchelf --set-rpath ${rpath}:$out/opt/Rocket.Chat $file || true
    done
    # Fix the desktop link
    substituteInPlace $out/share/applications/rocketchat-desktop.desktop \
      --replace /opt/Rocket.Chat/ $out/bin/
  '';

  meta = with lib; {
    homepage = "https://rocket.chat";
    description = "Official Desktop Client for Rocket.Chat";
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
