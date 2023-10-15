module Buffer = {
  type t

  @send
  external toString: t => string = "toString"
}

module Process = {
  @module("node:process")
  external exit: (int) => () = "exit"

  @val @scope("process")
  external env: Dict.t<string> = "env"
}

module Path = {
  @module("node:path")
  external join: (string, string) => string = "join"

  @module("node:path")
  external dirname: (string) => string = "dirname"
}

module Url = {
  @module("node:url")
  external fileURLToPath: (string) => string = "fileURLToPath"
}

