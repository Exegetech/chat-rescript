type t = {
  from: string,
  message: string,
  timestamp: float,
}

let getServerUsername: () => string

let create: (~from: string, ~message: string) => t

let serializeOne: (t) => result<string, string>

let serializeMany: (array<t>) => result<string, string>

let deserializeOne: (string) => result<t, string>

let deserializeMany: (string) => result<array<t>, string>
