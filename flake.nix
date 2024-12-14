{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
	  python = pkgs.python3.override {
			self = python;
			packageOverrides = pyfinal: pyprev: {
				octave-kernel = pyfinal.callPackage ./octave-kernel.nix{};
			};
	  };
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
		octaveFull
		(python.withPackages(python-pkgs:[
			python-pkgs.octave-kernel
		]))
        ];
      };
    }
  );
}
