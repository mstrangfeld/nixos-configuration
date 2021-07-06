self: super:
let
  click7Version = "7.1.2";
  click7 = super.python38Packages.click.overrideAttrs (old: {
    version = click7Version;
    src = super.python38Packages.fetchPypi {
      pname = old.pname;
      version = click7Version;
      sha256 = "sha256-0rUlXHxjSbwb0eWeCM0SrLvWPOZJ8liHVXg6qU37axo=";
    };
  });
  click7-didyoumean = super.python38Packages.click-didyoumean.overrideAttrs (old: {
    propagatedBuildInputs = [ click7 ];
  });
in
{
  watson = super.watson.overrideAttrs (old: {
    propagatedBuildInputs = with super.python38Packages; [ arrow click7 click7-didyoumean requests ];
  });
}
