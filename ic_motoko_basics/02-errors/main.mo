import D "mo:base/Debug";
import P "mo:base/Prelude";
import Error "mo:base/Error";
import Result "mo:base/Result";
import Option "mo:base/Option";


actor BrokenActor {
    type Result<T,E> = Result.Result<T, E>;

    public func trycatch() : async () {
        try {
            let x = await error();
        } catch (e) {
            D.print(debug_show(Error.message(e)));
        };
    };

    public shared func error() : async () {
        throw Error.reject("system_fatal");
    };

    public shared func itsatrap() : async () {
        // both will stop execution when compiled with motoko compiler
        // TODO: test with dfx
        D.trap("stop");
        P.xxx()
    };

    public shared func option(i : Int) : async ?Int {
        if (i > 10) { null } else { ?i }
    };

    public shared func result(i : Int) : async Result<Text, ?Text> {
        // result combined with option for erronous cases
        if (i > 10) { #ok("all good") } else { #err(?"broken") }
    };
};
D.print("\n" # "try-catching erronouse actor function inside another actors' function");
let x = await BrokenActor.trycatch();
D.print(debug_show(x));

D.print("\n" # "try-catching erronouse actor function outside of actor");
try await BrokenActor.error() catch (e) {
    D.print(debug_show(Error.message(e)));
};

D.print("\n" # "working with Option");
switch (await BrokenActor.option(11)) {
    case (?value) {
        D.print(debug_show(value));
    };
    case (null) {
        D.print(debug_show(null));
    };
};

D.print("\n" # "working with Result");
switch (await BrokenActor.result(1)) {
    case (#ok(v)) {
        D.print(debug_show(v));
    };
    case (#err(e)) {
        D.print(debug_show(Option.get(e, "cant")));
    };
};
