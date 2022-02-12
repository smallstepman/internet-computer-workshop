let upstream = https://github.com/dfinity/vessel-package-set/releases/download/mo-0.6.7-20210818/package-set.dhall sha256:c4bd3b9ffaf6b48d21841545306d9f69b57e79ce3b1ac5e1f63b068ca4f89957
let Package =
    { name : Text, version : Text, repo : Text, dependencies : List Text }

let
  -- This is where you can add your own packages to the package-set
  additions =
    [] : List Package

let overrides = [
    {
    name= "BigTest",
    repo= "git@github.com:matthewhammer/motoko-bigtest",
    version= "master",
    dependencies= ["base", "crud"]
    },
    {
    name = "SHA256",
    repo = "https://github.com/matthewhammer/motoko-sha",
    version = "master",
    dependencies = ["base"]
    },
    {
    name = "BigMap",
    repo = "git@github.com:dfinity/bigmap-poc.git",
    version = "master",
    dependencies = ["base", "SHA256"]
    }
] : List Package

in  upstream # additions # overrides
