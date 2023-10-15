type t

@new
external createSocket: (string) => t = "WebSocket"

type messageEvent = {
  data: string,
}

@set
external set_onMessage: (t, (messageEvent) => ()) => () = "onmessage"
