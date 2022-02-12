let upstream = https://github.com/dfinity/vessel-package-set/releases/download/mo-0.6.7-20210818/package-set.dhall sha256:c4bd3b9ffaf6b48d21841545306d9f69b57e79ce3b1ac5e1f63b068ca4f89957
let Package =
    { name : Text, version : Text, repo : Text, dependencies : List Text }

let
  -- This is where you can add your own packages to the package-set
  additions =
    [] : List Package

let overrides = [
   { name = "sequence"
   , repo = "https://github.com/matthewhammer/motoko-sequence.git"
   , version = "v0.1.1"
   , dependencies = [ "base" ]
   },
   { name = "graph"
   , repo = "https://github.com/matthewhammer/motoko-graph.git"
   , version = "master"
   , dependencies = [ "base", "crud", "sequence" ]
   }
] : List Package
  {- This is where you can override existing packages in the package-set

     For example, if you wanted to use version `v2.0.0` of the foo library:
  overrides =
    [] : List Package
  -}

in  upstream # additions # overrides
