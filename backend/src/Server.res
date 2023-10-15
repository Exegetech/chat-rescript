open Fastify

let env = Dict.get(Node.Process.env, "NODE_ENV")

@val external importMetaUrl: string = "import.meta.url"

let dirname = importMetaUrl
  -> Node.Url.fileURLToPath
  -> Node.Path.dirname

let fastify = create({ logger: true })

switch env {
  | None => {
    fastify->registerStatic(fastifyStatic, {
      root: Node.Path.join(dirname, "public"),
    })
  }
  | _ => ()
}

fastify->register(fastifyCors)
fastify->register(fastifyWebsocket)

fastify->addHook(PreValidation, async (request, reply) => {
  let path = request.routeOptions.url
  let username = Dict.get(request.query, "username")

  switch (path, username) {
    | ("/chat", None) => reply
      ->HTTP.code(Forbidden)
      ->HTTP.send("Connection rejected")
    | _ => ()
  }
})

fastify->httpGet("/chat", async (_request, reply) => {
  let payload = Chat.getChatHistory()
    -> Message.ToClient.serializeMany

  switch payload {
    | Error(error) => fastify.log->Log.logError(error)
    | Ok(payload) => reply
      ->HTTP.code(Okay)
      ->HTTP.send(payload)
  }
})

fastify->register(async (fastify) => {
  fastify->socketGet("/room", (connection, request) => {
    let username = request.query
      -> Dict.get("username")
      -> Option.getExn
    
    Chat.handleClient(~username, ~socket=connection.socket, ~onError=(errMsg) => {
      fastify.log->Log.logError(errMsg)
    })
  })
})

let start = async () => {
  try {
    await fastify->listen({ port: 3000 })
  } catch {
    | Exn.Error(obj) =>
      switch Exn.message(obj) {
        | Some(m) => fastify.log->Log.logError(m)
	| None => ()
      }

      Node.Process.exit(1)
  }
}

let _ = await start()
