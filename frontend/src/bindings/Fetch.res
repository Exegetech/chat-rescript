module Response = {
  type t

  @send
  external text: (t) => promise<string> = "text"
}

@val
external fetch: (string) => promise<Response.t> = "fetch"

