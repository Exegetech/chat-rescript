open Fastify

let fastify = createFastify({ logger: true })
fastify->register(fastifyWebsocket)

type query = {
  username: string,
}

fastify->addHook(PreValidation, async (request, reply) => {
  open Http

  let path = request.routeOptions.url
  let username = Dict.get(request.query, "username")

  switch (path, username) {
    | ("/chat", None) => {
	reply
	  ->code(Forbidden)
	  ->send("Connection rejected")
      }
    | _ => ()
  }
})

fastify->register(async (fastify) => {
  fastify->get("/chat", { websocket: true }, (connection, request) => {
    open Socket

    switch Dict.get(request.query, "username") {
      | None => {
	  fastify.log->logError("TODO: WHAT TO DO HERE")
	}
      | Some(username) => {
	  Chat.handleClient(username, connection.socket)
      }
    }
  })
})

let start = async () => {
  try {
    await fastify->listen({ port: 3000 })
  } catch {
    | Js.Exn.Error(obj) =>
      switch Js.Exn.message(obj) {
        | Some(m) => {
	  fastify.log->logError(m)
	}
	| None => ()
      }

      Node.exit(1)
  }
}

let _ = await start()
