import Array "mo:base/Array";
import D "mo:base/Debug";
import Nat "mo:base/Nat";
import Map "mo:base/RBTree";


D.print("\n" # "simple counter actor");
actor Counter {
  var count = 0;
  public shared func inc() : async () { count += 1 };
  public shared func read() : async Nat { count };
  public shared func bump() : async Nat {
    count += 1;
    count;
  };
};
let c = Counter;
D.print(debug_show(await c.read()));
D.print(debug_show(await c.inc()));
D.print(debug_show(await c.read()));



D.print("\n" # "assign actor to variable");
let a : actor {f : () -> (); g : () -> ()} = actor {
  public func f() {};
  public func g() {}
};
D.print(debug_show(a.f()));
var x : actor {f : () -> (); g : () -> ()} = actor {
  public func f() {};
  public func g() {}
};
D.print(debug_show(x.f()));



D.print("\n" # "passing actor as param to function");
let act1 = actor {func f() : Nat {7}};
func passeroo(x : actor {}) : Nat {3};
D.print(debug_show(passeroo(act1)));

let act2 = actor {public func f() : () {}}; // has to be public
func passeroo2(x : actor {f : () -> ()}) : Nat {3};
D.print(debug_show(passeroo2(act2)));

let act3 = actor {public func f() : async Nat {5}};
func passeroo3(x : actor {f : () -> async Nat}) : Nat {3};
D.print(debug_show(passeroo3(act3)));



D.print("\n" # "passing actor as param to function, then calling it");
let act4 = actor {public func f() : async Nat {5}};
func passeroo4(x : actor {f : () -> async Nat}) : async Nat {
    await x.f()
};
D.print(debug_show(await passeroo4(act4)));



D.print("\n" # "constructing actor with param passed to function");
func creactor(x: Nat ) : async actor {f : () -> async Nat} {
    actor {public func f() : async Nat {x}}
};
let creatced = await creactor(55);
D.print(debug_show(await creatced.f()));



D.print("\n" # "can't make it work -- actor wrapped with class");
/// main.mo:72.5-74.6: type error [M0038], misplaced await
// class Classtor() {
//     actor TestActor {
//         var x=1;
//     };
// };



D.print("\n" # "actor with class declaration");
actor Alass {
    class TestClass() {
        public let x = -1;
    };
    let x = TestClass();
    D.print(debug_show(x.x));
};



D.print("\n" # "can't make it work -- actor with class declaration - trying to use declared class outside of the actor");
/// main.mo:81.16-81.25: type error [M0124], public actor field TestClass1 has non-shared function type
///  () -> TestClass1
// actor Olass {
//     public class TestClass1() {
//       // public shared func X() {};
//       // public let x = -1;
//     };
// };
// Olass.TestClass1.x;



D.print("\n" # "object wrapped with actor");
actor ObjectWrappedWithActor  {
    object Testi {
        public var x = 1;
        public func xx() { x := 15; };
    };
    public func read() : async Nat {
        Testi.x
    };
    public func modify() : async () {
        Testi.xx();
    };
};
D.print(debug_show(await ObjectWrappedWithActor.read()));
await ObjectWrappedWithActor.modify();
D.print(debug_show(await ObjectWrappedWithActor.read()));



D.print("\n" # "actor with class inside - proxy wrapped by object (class has only immutable fields)");
actor ImmutableClassWrappedInObjectWrappedWithActor  {
    object Testo {
        public class TestClassImmutable(init : Nat) {
          public let q = init;
        };
    };

    var oci = Testo.TestClassImmutable(0);

    public func inception_factory(i : Nat) : async Testo.TestClassImmutable {
        Testo.TestClassImmutable(i)
    };
    public func inception_read() : async Nat {
        oci.q
    };
    public func inception_overwrite(i : Nat) : async () {
        oci := Testo.TestClassImmutable(i);
    };
};
D.print(debug_show(await ImmutableClassWrappedInObjectWrappedWithActor.inception_factory(2)));
D.print(debug_show(await ImmutableClassWrappedInObjectWrappedWithActor.inception_read()));
await ImmutableClassWrappedInObjectWrappedWithActor.inception_overwrite(888);
D.print(debug_show(await ImmutableClassWrappedInObjectWrappedWithActor.inception_read()));



D.print("\n" # "actor with class inside - proxy wrapped by object (class has mutable fields)");
actor MutableClassWrappedInObjectWrappedWithActor  {
    object Testo {
        public class TestClassMutable(init : Nat) {
            var q = init;
            public shared func modify(i : Nat) : async () { q := i; };
            public shared func read() : async Nat { q };
        };
    };

    var ocm = Testo.TestClassMutable(0);

    public func inception_mutable_factory(i : Nat) : async Testo.TestClassMutable {
        Testo.TestClassMutable(i)
    };
};
let t = await MutableClassWrappedInObjectWrappedWithActor.inception_mutable_factory(2);
let v = await MutableClassWrappedInObjectWrappedWithActor.inception_mutable_factory(22);
D.print(debug_show(await t.read()));
D.print(debug_show(await v.read()));
await t.modify(33);
let queued_v = v.modify(11);
D.print(debug_show(await t.read()));
D.print(debug_show(await v.read()));



D.print("\n" # "actor with malicious query func");
// TODO: test with dfx
actor QueryButNotReally {
  var count = 0;

  public shared query func maliciousPeek() : async () {
      count := 3;
  };

  public shared query func peek() : async Nat {
      count
  };
};
D.print(debug_show(await QueryButNotReally.peek()));
await QueryButNotReally.maliciousPeek();
D.print(debug_show(await QueryButNotReally.peek()));

// TODO: It is a compile-time error for a query method to call an actor function since this would violate dynamic restrictions imposed by the Internet Computer. Calls to ordinary functions are permitted.




D.print("\n" # "actor classes");
actor class ACounter(init : Nat) {
  var count = init;

  public func inc() : async () { count += 1 };

  public func read() : async Nat { count };

  public func bump() : async Nat {
    count += 1;
    count;
  };
};
let C1 = await ACounter(1);
let C2 = await ACounter(2);
D.print(debug_show(await C1.read(), await C2.read()));



