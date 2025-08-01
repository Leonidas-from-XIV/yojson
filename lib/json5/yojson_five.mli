(**
   This module contains the parsers and pretty printers for JSON 5, as defined
   by the JSON 5 spec.
*)

module Safe : sig
  (**
     This module is the equivalent of {!Yojson.Safe}, thus parses to the same data
     structure, except it does so by the JSON 5 parsing rules.

     This module is recommended for intensive use or OCaml-friendly use of
     JSON.
  *)

  type t = Yojson.Safe.t
  (** This type represents the result of reading JSON5 data. All the utility
      functions of {!Yojson.Safe.Util} can be used with values of this type. *)

  val from_string : ?fname:string -> ?lnum:int -> string -> (t, string) result
  (** Attempts to parse JSON5 values from the supplied string.
      @param fname The file name to use in error messages
      @param lnum The line number to use in error messages *)

  val from_channel :
    ?fname:string -> ?lnum:int -> in_channel -> (t, string) result
  (** Like {!from_string} but reads the data from an [in_channel]. *)

  val from_file : ?fname:string -> ?lnum:int -> string -> (t, string) result
  (** Like {!from_string} but the parameter is the file name of the file
      to open and read. *)

  val to_string :
    ?buf:Buffer.t -> ?len:int -> ?suf:string -> ?std:bool -> t -> string
  (** Converts the parsed data into a string representation.
      @param buf allows to reuse an existing buffer created with
        [Buffer.create]. The buffer is cleared of all contents before starting
        and right before returning.
      @param len initial length of the output buffer.
      @param suf appended to the output as suffix, defaults to the empty
        string
      @param std Unused, retained to match the signature of
        {!Yojson.Safe.to_string}.
      *)

  val to_channel :
    ?buf:Buffer.t ->
    ?len:int ->
    ?suf:string ->
    ?std:bool ->
    out_channel ->
    t ->
    unit
  (** Like {!to_string} but will write into the specified [out_channel]. *)

  val to_output :
    ?buf:Buffer.t ->
    ?len:int ->
    ?suf:string ->
    ?std:bool ->
    < output : string -> int -> int -> int > ->
    t ->
    unit
  (** Like {!to_string} but will write into an object with a method [output] of
      type [string -> int -> int -> int]. The first argument is the string
      representation of the JSON data, the second one is the start value
      (always 0), the second is the length of the data and the return value
      has to be an int but its value can be arbitrary as it is never used. *)

  val to_file : ?len:int -> ?std:bool -> ?suf:string -> string -> t -> unit
  (** Like {!to_string} but will open and write to the file specified. *)

  val pp : Format.formatter -> t -> unit
  (** Pretty-printer for values of type {!t}. *)

  val equal : t -> t -> bool
  (** [equal a b] is the monomorphic equality.
        Determines whether two JSON values are considered equal. In the case of
        JSON objects, the order of the keys does not matter, except for
        duplicate keys which will be considered equal as long as they are in the
        same input order.
      *)
end

module Basic : sig
  (**
   The equivalent of {!Yojson.Basic} but for reading and writing JSON5 data.

   The main advantage of this module is its simplicity.
   *)

  type t = Yojson.Basic.t
  (** This type represents JSON5 data in the {!Yojson.Basic} format. *)

  val from_string : ?fname:string -> ?lnum:int -> string -> (t, string) result
  (** Attempts to parse JSON5 values from the supplied string.
      @param fname The file name to use in error messages
      @param lnum The line number to use in error messages *)

  val from_channel :
    ?fname:string -> ?lnum:int -> in_channel -> (t, string) result
  (** Like {!from_string} but reads the data from an [in_channel]. *)

  val from_file : ?fname:string -> ?lnum:int -> string -> (t, string) result
  (** Like {!from_string} but the parameter is the file name of the file
      to open and read. *)

  val to_string :
    ?buf:Buffer.t -> ?len:int -> ?suf:string -> ?std:bool -> t -> string
  (** Converts the parsed data into a string representation.
      @param buf allows to reuse an existing buffer created with
        [Buffer.create]. The buffer is cleared of all contents before starting
        and right before returning.
      @param len initial length of the output buffer.
      @param suf appended to the output as suffix, defaults to the empty
        string
      @param std Unused, retained to match the signature of
        {!Yojson.Basic.to_string}.
      *)

  val to_channel :
    ?buf:Buffer.t ->
    ?len:int ->
    ?suf:string ->
    ?std:bool ->
    Stdlib.out_channel ->
    t ->
    unit
  (** Like {!to_string} but will write into the specified [out_channel]. *)

  val to_output :
    ?buf:Buffer.t ->
    ?len:int ->
    ?suf:string ->
    ?std:bool ->
    < output : string -> int -> int -> int > ->
    t ->
    unit
  (** Like {!to_string} but will write into an object with a method [output] of
      type [string -> int -> int -> int]. The first argument is the string
      representation of the JSON data, the second one is the start value
      (always 0), the second is the length of the data and the return value
      has to be an int but its value can be arbitrary as it is never used. *)

  val to_file : ?len:int -> ?std:bool -> ?suf:string -> string -> t -> unit
  (** Like {!to_string} but will open and write to the file specified. *)

  val pp : Format.formatter -> t -> unit
  (** Pretty-printer for values of type {!t}. *)

  val equal : t -> t -> bool
  (** [equal a b] is the monomorphic equality.
        Determines whether two JSON values are considered equal. In the case of
        JSON objects, the order of the keys does not matter, except for
        duplicate keys which will be considered equal as long as they are in the
        same input order.
      *)
end
