{ root, machineName }:
let
  componentRoot = root + "/components";

  mkComponentPath = name:
    let
      p = componentRoot + "/${name}/${name}.nix";
    in
      if builtins.pathExists p then p else
        throw "Machine '${machineName}' references missing component '${name}'";
in
{
  paths = names: map mkComponentPath names;
}
