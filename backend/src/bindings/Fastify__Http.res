module Request = Fastify__Request
module Reply = Fastify__Reply

type statusCode =
  | @as(403)
    Forbidden

@send
external code: (Reply.t, statusCode) => Reply.t = "code"

@send
external send: (Reply.t, string) => () = "send"

type handler = (Request.t, Reply.t) => promise<()>
