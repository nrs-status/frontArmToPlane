{ lclInputs }:
with lclInputs;
with tclib.types;
tc TypeDecl {
  typeName = "OutputDecl";
  preds = [
    (tclib.predicates.isAttrs)
    (tfield Attrset "nixpkgs")
    (tfield Attrset "nixpkgsConfig")
    (tfield NixFunction "types")
    (tfield NixFunction "lclInputs")
    (tfield (List String) "packagesToProvide")
    (tfield (List String) "envsToProvide")
    (tfield (List String) "supportedSystems")
  ];
}
