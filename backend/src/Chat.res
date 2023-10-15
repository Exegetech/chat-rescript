module Socket = Fastify.Socket

let server = "server"

let clients: Dict.t<Socket.t> = Dict.make()

let createMessage = (from: string, message: string): string => {
  let time = Date.make()->Date.getTime

  let dict = Dict.fromArray([
    ("from", JSON.Encode.string(from)),
    ("message", JSON.Encode.string(message)),
    ("timestamp", JSON.Encode.float(time)),
  ]) -> JSON.Encode.object

  JSON.stringify(dict)
}

let broadcast = (from: string, message: string) => {
  let jsonMsg = createMessage(from, message)

  clients
  -> Dict.toArray
  -> Array.forEach(((username, socket)) => {
    if username !== from {
      socket->Socket.send(jsonMsg)
    }
  })
}


let handleClient = (username: string, client: Socket.t) => {
  Dict.set(clients, username, client)

  broadcast(server, `${username} joined`)

  client->Socket.onMessage((message) => {
    broadcast(username, message)
  })

  client->Socket.onClose(() => {
    broadcast(server, `${username} left`)
  })
}
