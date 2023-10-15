module Request = Fastify__Request
module Reply = Fastify__Reply

type t

type connection = {
  socket: t
}

type handler = (connection, Request.t) => ()

@send
external onMessage: (t, @as("message") _, (string) => ()) => () = "on"

@send
external onClose: (t, @as("close") _, () => ()) => () = "on"

@send
external send: (t, string) => () = "send"

type server = {
  clients: array<t>
}
