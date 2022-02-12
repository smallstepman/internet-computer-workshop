export const idlFactory = ({ IDL }) => {
  const anon_class_1_1 = IDL.Service({
    'bump' : IDL.Func([], [IDL.Nat], []),
    'identify' : IDL.Func([], [IDL.Principal], []),
    'identifyOwner' : IDL.Func([], [IDL.Principal], []),
    'inc' : IDL.Func([], [], []),
    'read' : IDL.Func([], [IDL.Nat], []),
  });
  return anon_class_1_1;
};
export const init = ({ IDL }) => { return [IDL.Nat]; };
