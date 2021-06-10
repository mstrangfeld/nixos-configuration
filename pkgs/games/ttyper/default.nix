{ lib, rustPlatform }:
let inherit (srcs) ttyper; in
rustPlatform.buildRustPackage rec {
  pname = "ttyper";
  inherit (ttyper) version;

  src = ttyper;

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  meta = with lib; {
    description = "Terminal-based typing test.";
    homepage = "https://github.com/max-niederman/ttyper";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ maintainers.mstrangfeld ];
    inherit version;
  };
}
