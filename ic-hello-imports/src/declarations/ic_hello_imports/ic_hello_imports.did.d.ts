import type { Principal } from '@dfinity/principal';
export type Name = string;
export type Phone = string;
export interface _SERVICE {
  'insert' : (arg_0: Name, arg_1: Phone) => Promise<undefined>,
  'lookup' : (arg_0: Name) => Promise<[] | [Phone]>,
}
