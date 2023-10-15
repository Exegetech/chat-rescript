module Http = Fastify__Http
module Socket = Fastify__Socket

type log

type fastify = {
  log: log,
  websocketServer: Socket.server
}

type createOption = {
  logger: bool
}

@module("fastify")
external createFastify: (createOption) => fastify = "default"

type fastifyWebsocket = (fastify) => promise<()>

@module("@fastify/websocket")
external fastifyWebsocket: fastifyWebsocket = "default"

@send
external register: (fastify, (fastify) => promise<()>) => () = "register"

type getOption = {
  websocket: bool,
}

type hookType =
  | @as("preValidation")
    PreValidation

@send
external addHook: (fastify, hookType, Http.handler) => () = "addHook"

@send
external get: (fastify, string, getOption, Socket.handler) => () = "get"


type listenOption = {
  port: int
}

@send
external logError: (log, string) => () = "error"

@send
external listen: (fastify, listenOption) => promise<()> = "listen"
