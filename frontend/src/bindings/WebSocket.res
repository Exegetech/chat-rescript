type t

type messageEvent = {
  data: string,
}

@new
external create: (string) => t = "WebSocket"

@set
external set_onOpen: (t, () => ()) => () = "onopen"

@set
external set_onMessage: (t, (messageEvent) => ()) => () = "onmessage"

@send
external close: (t) => () = "close"

@send
external send: (t, string) => () = "send"
