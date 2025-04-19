listarg: 
builtins.foldl' (acc: element: acc && element) true listarg
