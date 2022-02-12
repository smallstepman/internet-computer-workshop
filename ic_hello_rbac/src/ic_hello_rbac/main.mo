shared({ caller = initializer }) actor class(init : Nat) {

  let owner = initializer;

  var count = init;

  public shared(msg) func inc() : async () {
    assert (owner == msg.caller);
    count += 1;
  };

  public func read() : async Nat {
    count
  };

  public shared(msg) func bump() : async Nat {
    assert (owner == msg.caller);
    count := 1;
    count;
  };

  public shared(msg) func identify() : async Principal {
      return msg.caller;
  };


  public shared(msg) func identifyOwner() : async Principal {
      return owner;
  };
}
