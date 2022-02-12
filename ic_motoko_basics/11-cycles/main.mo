import Cycles "mo:base/ExperimentalCycles";

shared(msg) actor class PiggyBank(
  benefit : shared () -> async (),
  capacity: Nat
  ) {

  let owner = msg.caller;

  var savings = 0;

  public shared(msg) func getSavings() : async Nat {
    assert (msg.caller == owner);
    return savings;
  };

  public func deposit() : async () {
    let amount = Cycles.available();
    let limit : Nat = capacity - savings;
    let acceptable =
      if (amount <= limit) amount
      else limit;
    let accepted = Cycles.accept(acceptable);
    assert (accepted == acceptable);
    savings += acceptable;
  };

  public shared(msg) func withdraw(amount : Nat)
    : async () {
    assert (msg.caller == owner);
    assert (amount <= savings);
    Cycles.add(amount);
    await benefit();
    let refund = Cycles.refunded();
    savings -= amount - refund;
  };

};


actor Alice {

  public func test() : async () {

    Cycles.add(10_000_000_000_000);
    let porky = await PiggyBank(Alice.credit, 1_000_000_000);

    assert (0 == (await porky.getSavings()));

    Cycles.add(1_000_000);
    await porky.deposit();
    assert (1_000_000 == (await porky.getSavings()));

    await porky.withdraw(500_000);
    assert (500_000 == (await porky.getSavings()));

    await porky.withdraw(500_000);
    assert (0 == (await porky.getSavings()));

    Cycles.add(2_000_000_000);
    await porky.deposit();
    let refund = Cycles.refunded();
    assert (1_000_000_000 == refund);
    assert (1_000_000_000 == (await porky.getSavings()));

  };

  // Callback for accepting cycles from PiggyBank
  public func credit() : async () {
    let available = Cycles.available();
    let accepted = Cycles.accept(available);
    assert (accepted == available);
  }

};


// TODO: test dfx
await Alice.test()
