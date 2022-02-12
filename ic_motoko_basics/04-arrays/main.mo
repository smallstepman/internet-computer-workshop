import Array "mo:base/Array";
import D "mo:base/Debug";

D.print("\n" # "immutable array with immutable elements");
let i : [Nat] = [1,3,5];
D.print(debug_show(i));

D.print("\n" # "immutable array with mutable elements");
var x : Nat       = 0 ;
let y : [var Text] = [var "hi"] ;
D.print(debug_show(y));
y[0] := "welcome";
D.print(debug_show(y));

D.print("\n" # "mutable array with immutable elements");
var m : [Nat] = [1,3,5];
D.print(debug_show(m));
m := [5,5,5];
D.print(debug_show(m));

D.print("\n" # "mutable array with mutable elements");
var u : [var Nat] = [var 1,3,5];
D.print(debug_show(u));
u := [var 5,5,5];
D.print(debug_show(u));
u[2] := 55;
D.print(debug_show(u));

D.print("\n" # "array with custom types");
type Custom = (Nat, Text);
let c : [var Custom] = [var (3, "x"), (5, "a")];
D.print(debug_show(c));
c[1] := (11, "rr");
D.print(debug_show(c));

D.print("\n" # "Array.init constructor - allocate mutable array with dynamic size");
var size : Nat = 14 ;
let d : [var Nat] = Array.init<Nat>(size, 3);
D.print(debug_show(d));

D.print("\n" # "Array.tabulate constructor - generation function");
let array2 : [Nat] = Array.tabulate<Nat>(7, func(i:Nat) : Nat {
    if ( i == 2 ) {
        i ** i ** i
    }
    else {
        i
    }
});
D.print(debug_show(array2));

