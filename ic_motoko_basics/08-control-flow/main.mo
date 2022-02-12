/// only non- or semi-trivial stuff

import Debug "mo:base/Debug";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import List "mo:base/List";

func bodyreturn() : Nat {
    20
};



for (c in "ran".chars()) {
      Debug.print(debug_show(c));
};


label letters for (c in "ran!efefeseem".chars()) {
  if (c == '!') { break letters };
  Debug.print(debug_show(c));
  // ...
};


let address = label exit : ?(Text, Text) {
  let splitted = Text.split("us@dfn", #char '@');
  let array = Iter.toArray<Text>(splitted);
  if (array.size() != 2) { break exit(null) };
  let account = array[0];
  let host = array[1];
  ?(account, host)
};
Debug.print(debug_show(address));

var i = 0;
for (j in Iter.range(0, 10)) {
  Debug.print(debug_show(j));
  assert(j == i);
  i += 1;
};


switch (List.tabulate(5, func X(i:Nat) : Nat {i})) {
    case (?(head, tail)) {
        Debug.print(debug_show((head,tail)));
    };
    case _ false;
  }
