import D "mo:base/Debug";


// try to return async context from functioactor to interfere with its operation: each await suspends execution, allowing an interloper to change the state of the actor. By design, the explicit awaits make the potential points of interference clear to the reader.



// For example, the implementation of bump() above is guaranteed to increment and read the value of count, in one atomic step. The alternative implementation:

  public shared func bump() : async Nat {
    await inc();
    await read();
  };
// does not have the same semantics and allows another client of the
