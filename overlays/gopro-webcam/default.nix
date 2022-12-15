{ lib, stdenv, fetchFromGitHub, makeWrapper, vlc, ffmpeg, curl, iproute2, ... }:
stdenv.mkDerivation {
  pname = "gopro-webcam";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "jschmid1";
    repo = "gopro_as_webcam_on_linux";
    rev = "master";
    sha256 = "sha256-3HETdVksXGudGNEK6uHVDoA+f3nkDe7m5walI6F3XTM=";
  };

  buildInputs = [ makeWrapper ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    install -m755 gopro $out/bin/gopro
    wrapProgram $out/bin/gopro --prefix PATH : ${
      lib.makeBinPath [ vlc ffmpeg curl iproute2 ]
    }
  '';

  meta = {
    description = "Allows to use your GoPro camera as a webcam on linux";
    homepage = "https://github.com/jschmid1/gopro_as_webcam_on_linux";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ mstrangfeld ];
    platforms = lib.platforms.unix;
  };
}
