{pkgs, stdenv, lib, inputs, mkShell }:

with pkgs;
#with inputs.floxpkgs.inputs.nixpkgs.evalCatalog.${pkgs.system};
mkShell {
  buildInputs = [ autoconf
    automake
    curl
    fwup
    git
    rebar3
    squashfsTools
    x11_ssh_askpass     
    pkgs.beam.packages.erlangR25.elixir_1_14
    pkg-config
    jq 
    mix2nix  ];
  #env = {};
  shellHook = ''
    SUDO_ASKPASS=${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass
    export MIX_TARGET="rpi0"
  '';
  postShellHook = ''
    # Generic shell variables
    # As an example, you can run any CLI commands to customize your development shell
    # This creates mix variables and data folders within your project, so as not to pollute your system
    mkdir -p .nix-mix
    mkdir -p .nix-hex
    export MIX_HOME=$PWD/.nix-mix
    export HEX_HOME=$PWD/.nix-hex
    export PATH=$MIX_HOME/bin:$PATH
    export PATH=$HEX_HOME/bin:$PATH
  '';
}
