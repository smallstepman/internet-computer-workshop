import D "mo:base/Debug";

shared({caller = owner}) actor class Counter1(init : Nat) {

  var count : Nat = init;


  public shared({caller}) func inc() : async () {
    assert (owner == caller);
    count += 1;
  };

  // ...
};

let x = await Counter1(1);



shared(msg) actor class Counter2(init : Nat) {

  let owner = msg.caller;

  var count = init;

  public shared(msg) func inc() : async () {
    assert (owner == msg.caller);
    count += 1;
  };

  public func read() : async Nat {
    count
  };

  public func readOwner() : async Principal {
    owner
  };


  public func readMsg() : async {caller : Principal} {
    msg
  };

  public shared(msg) func bump() : async Nat {
    assert (owner == msg.caller);
    count := 1;
    count;
  };
};
let gee = await Counter2(1);
D.print(debug_show(await gee.readOwner()));
D.print(debug_show(await gee.readMsg()));
D.print(debug_show(await gee.inc()));
D.print(debug_show(await gee.read()));
D.print(debug_show(await gee.bump()));
