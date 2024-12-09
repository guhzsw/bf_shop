{
  description = "PHP environment for bf_shop";
  nixpkgs = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-23.05.tar.gz";
  pkgs = import nixpkgs {};
  deps = with pkgs; [
    php82
    php82Extensions.pdo
    php82Extensions.pdo_mysql
    php82Extensions.mysqli
    php82Extensions.mbstring
    php82Extensions.curl
    php82Extensions.gd
    php82Extensions.xml
    php82Extensions.zip
  ];
}
