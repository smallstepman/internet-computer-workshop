import Array "mo:base/Array";
import D "mo:base/Debug";

D.print("\n" # "objects - mutable, local-only");
object counter {
    var count = 0;
    public var cunt = 0;
    public func inc() { count += 1 };
    public func read() : Nat { count };
    public func bump() : Nat { inc(); read() };
};

var o = counter;
D.print(debug_show(o.read()));
D.print(debug_show(counter.read()));

counter.inc();
D.print(debug_show(counter.read()));
D.print(debug_show(o.read()));

o.inc();
D.print(debug_show(counter.read()));
D.print(debug_show(o.read()));

D.print(debug_show(o.cunt));


D.print("\n" # "class definition inside an object");
object rounter {
    var count = 0;
    public var cunt = 0;
    public func inc() { count += 1 };
    public func read() : Nat { count };
    public func bump() : Nat { inc(); read() };
    public class Test() {
        public var c = 877;
        public func inc() { c += 1 };
    };
};
var t = rounter.Test();
var p = rounter.Test();
D.print(debug_show(t.c));
t.inc();
D.print(debug_show(t.c));
D.print(debug_show(p.c));


D.print("\n" # "object inside a class");
class Test() {
    public object nested {
        var count = 0;
        public func inc() { count += 1 };
        public func read() : Nat { count };
    };
    object hidden_nested {
        var count = 9;
        public func inc() { count += 1 };
        public func read() : Nat { count };
    };
    public func digout() : Nat { hidden_nested.read() };
    public func digup() { hidden_nested.inc() };
};

var r = Test();
D.print(debug_show(r.nested.read()));
D.print(debug_show(r.digout()));
r.digup();
D.print(debug_show(r.digout()) # "\n");

var q = Test();
q.nested.inc();
D.print(debug_show(q.nested.read()));
D.print(debug_show(r.nested.read()));
D.print(debug_show(q.digout()));
q.digup();
q.digup();
q.digup();
q.digup();
D.print(debug_show(q.digout()));
D.print(debug_show(r.digout()));



D.print("\n" # "function spawning objects (mimics functionality of scenario where object is wrapped in class)");
type Counter = { inc : () -> Nat };
func Counter() : Counter =
  object {
    var c = 0;
    public func inc() : Nat { c += 1; c }
  };
D.print(debug_show(Counter().inc()));


D.print("\n" # "class constructor");
class Counteroso(init : Nat) {
  var c = init;
  public func inc() : Nat { c += 1; c };
};
var a = Counteroso(10);
D.print(debug_show(a.inc()));
a := Counteroso(15);
D.print(debug_show(a.inc()));


D.print("\n" # "class type aguments aka generics");
class CounterStrike<X>(init: X) {
    var pocket = init;
    public func ret() : X { pocket };
};
let cs = CounterStrike("hello");
D.print(debug_show(cs.ret()));
let cp = CounterStrike(3);
D.print(debug_show(cp.ret()));


D.print("\n" # "class type annotations aka class traits");
type Adder<X> = { add : X -> Nat };
class CounterAdder<X>(init : X) : Adder<X> {
  var buffer = init;
  public func add(x : X) : Nat { 3 };
  // public func add(x : X) : Int { 3 }; // will throw type error
};
let ca = CounterAdder("hello");
D.print(debug_show(ca.add()));
