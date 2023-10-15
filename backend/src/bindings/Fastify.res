module Request = {
  type routeOptions = {
    url: string
  }

  type t = {
    routeOptions: routeOptions,
    query: Dict.t<string>
  }
}

module Reply = {
  type t
}

module HTTP = {
  type statusCode =
    | @as(200)
      Okay
    | @as(403)
      Forbidden

  type handler = (Request.t, Reply.t) => promise<()>

  @send
  external code: (Reply.t, statusCode) => Reply.t = "code"

  @send
  external send: (Reply.t, string) => () = "send"
}

module WebSocket = {
  type t

  type server = {
    clients: array<t>
  }

  type connection = {
    socket: t
  }

  type handler = (connection, Request.t) => ()

  @send
  external onOpen: (t, @as("open") _, () => ()) => () = "on"

  @send
  external onMessage: (t, @as("message") _, (Node.Buffer.t) => ()) => () = "on"

  @send
  external onClose: (t, @as("close") _, () => ()) => () = "on"

  @send
  external send: (t, string) => () = "send"
}

module Log = {
  type t 

  @send
  external logError: (t, string) => () = "error"
}

type t = {
  log: Log.t,
  websocketServer: WebSocket.server
}

type createOption = {
  logger: bool
}

type plugin = (t) => promise<()>

type getOption = {
  websocket: bool,
}

type hookType =
  | @as("preValidation")
    PreValidation
    
type listenOption = {
  port: int
}

@module("fastify")
external create: (createOption) => t = "default"

@module("@fastify/static")
external fastifyStatic: plugin = "default"

type staticOption = {
  root: string
}

@send
external registerStatic: (t, plugin, staticOption) => () = "register"

@module("@fastify/websocket")
external fastifyWebsocket: plugin = "default"

@module("@fastify/cors")
external fastifyCors: plugin = "default"

@send
external register: (t, plugin) => () = "register"

@send
external addHook: (t, hookType, HTTP.handler) => () = "addHook"

@send
external httpGet: (
  t,
  string,
  HTTP.handler,
) => () = "get"

@send
external socketGet: (
  t,
  string,
  // JSON literal is not in documentation 
  // https://github.com/rescript-association/rescript-lang.org/issues/550
  @as(json`{ websocket: true }`) _,
  WebSocket.handler,
) => () = "get"

@send
external listen: (t, listenOption) => promise<()> = "listen"

