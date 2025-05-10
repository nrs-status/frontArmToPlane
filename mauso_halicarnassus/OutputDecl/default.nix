{ lclInputs }:
with lclInputs;
with tclib.types;
tc TypeDecl {
  typeName = "OutputDecl";
  preds = [ 
    (tclib.predicates.mkHasExactFieldsPredicate {
      fields = [
      ];
    })
  ];
}
