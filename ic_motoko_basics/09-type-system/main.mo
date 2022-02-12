import D "mo:base/Debug";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Text "mo:base/Text";


let a = [ { x = 10 }, { x = 20 } ];
let b = [ { x = 12 }, { x = 20 } ];
D.print(debug_show(a == b)); //false

D.print(debug_show({ x = 10 } == { y = 20 })); //true


/// Comparing these two at the Any type means this comparison will return true no matter its arguments, so this doesn’t work as one might hope.
func eqa<A>(a : A, b : A) : Bool = a == b;
D.print(debug_show(eqa(true,0)));      // true
D.print(debug_show(eqa(false,0)));     // true
D.print(debug_show(eqa(false,true)));  // true



///
func contains<A>(eqA : (A, A) -> Bool, element : A, list : List.List<A>) : Bool {
  switch list {
    case (?(head, tail))
      eqA(element, head) or contains(eqA, element, tail);
    case null false;
  }
};
D.print(debug_show(contains(Nat.equal, 1, List.make(0))));
D.print(debug_show(contains(Int.equal, 1, List.make(1))));
D.print(debug_show(contains(Text.equal, "a", List.make("a"))));
D.print(debug_show(contains(Text.equal, "r", List.make("a"))));
