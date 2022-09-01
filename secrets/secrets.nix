let
  marvinKronos = builtins.readFile ./keys/user/${"marvin@Kronos.pub"};

  Eos = builtins.readFile ./keys/host/Eos.pub;
in {
  "passwords/nextcloud-admin-pass.age".publicKeys = [ marvinKronos Eos ];
  "passwords/nextcloud-db-pass.age".publicKeys = [ marvinKronos Eos ];
}
