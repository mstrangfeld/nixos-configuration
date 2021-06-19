self: super:
let
  version = "1.2.0";
in
{
  multilockscreen = super.multilockscreen.overrideAttrs (old: {
    inherit version;
    src = super.fetchFromGitHub {
      owner = "jeffmhubbard";
      repo = old.pname;
      rev = "v${version}";
      sha256 = "sha256-Eqfcfs6gg12GTo2l88pZCWr/GfjwaWvK6OkruL9a160=";
    };
  });
}
