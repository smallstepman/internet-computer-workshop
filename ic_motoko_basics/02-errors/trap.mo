import D "mo:base/Debug";
import P "mo:base/Prelude";

/// all of these will terminate program execution when ran as binary (non-ic/dfx)
D.trap("whooopsies");
P.xxx();
P.unreachable();
P.nyi();
assert false;
