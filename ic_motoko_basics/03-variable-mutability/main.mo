import D "mo:base/Debug";

/// lexically-scoped, immutable variables
let text : Text = "abc";
let num : Nat = 30;
// text := text # "xyz"; // error

/// lexically-scoped, mutable variables
var pair : (Text, Nat) = (text, num);
var text2 : Text = text;
text2 := text2 # "xyz";
text2 #= "xyz";
D.print(text2 # "\n");

/// shadowing is not permitted
// let text = "xxx";
// let text2 = "xxx";

/// let- vs var-bound variables
let test = text2;
D.print(test);
text2 #= "xyz";
D.print(test);
D.print(text2 # "\n");

