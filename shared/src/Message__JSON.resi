@unboxed
type rec json =
  | @as(false) False
  | @as(true) True
  | @as(null) Null
  | String(string)
  | Number(float)
  | Object(Dict.t<json>)
  | Array(array<json>)

let parse: (string) => result<json, string> 
let stringify: (json) => result<string, string>
