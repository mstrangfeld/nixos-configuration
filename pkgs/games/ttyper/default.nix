{ lib, rustPlatform, srcs, ... }:
let inherit (srcs) ttyper; in
rustPlatform.buildRustPackage rec {
  pname = "ttyper";
  inherit (ttyper) version;

  src = ttyper;

  cargoSha256 = "sha256-+Ub96G8AG28GIwrJqInfOC0xCWM7BRf++yGI1x41mfw=";

  meta = with lib; {
    description = "Terminal-based typing test.";
    homepage = "https://github.com/max-niederman/ttyper";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ maintainers.mstrangfeld ];
    inherit version;
  };
}
