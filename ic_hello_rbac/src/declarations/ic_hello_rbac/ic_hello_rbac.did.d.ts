import type { Principal } from '@dfinity/principal';
export interface anon_class_1_1 {
  'bump' : () => Promise<bigint>,
  'identify' : () => Promise<Principal>,
  'identifyOwner' : () => Promise<Principal>,
  'inc' : () => Promise<undefined>,
  'read' : () => Promise<bigint>,
}
export interface _SERVICE extends anon_class_1_1 {}
