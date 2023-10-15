type t = {
  from: string,
  message: string,
}

let create: (~from: string, ~message: string) => t

let serialize: (t) => result<string, string>

let deserialize: (string) => result<t, string>
