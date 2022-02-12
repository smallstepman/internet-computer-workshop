import M "mo:matchers/Matchers";
import S "mo:sequence/Sequence";
import G "mo:graph/Persistent";

actor {
    let x = S.defaultAppend();
    let graph = G.empty<Nat, Nat, Nat>(G.NodeId.nat());

    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };
};
