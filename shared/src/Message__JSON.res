@unboxed
type rec json =
  | @as(false) False
  | @as(true) True
  | @as(null) Null
  | String(string)
  | Number(float)
  | Object(Dict.t<json>)
  | Array(array<json>)

@val
@scope("JSON")
external parseExn: string => json = "parse"

@val
@scope("JSON")
external stringifyExn: json => string = "stringify"

let parse = (payload: string): result<json, string> => {
  try {
    payload
    -> parseExn
    -> Ok
  } catch {
    | Exn.Error(obj) => {
      switch Exn.message(obj) {
        | Some(msg) => Error(msg)
        | None => Error("Unknown error")
      }
    }
  }
}

let stringify = (payload: json): result<string, string> => {
  try {
    payload
    -> stringifyExn
    -> Ok
  } catch {
    | Exn.Error(obj) => {
      switch Exn.message(obj) {
        | Some(msg) => Error(msg)
        | None => Error("Unknown error")
      }
    }
  }
}
