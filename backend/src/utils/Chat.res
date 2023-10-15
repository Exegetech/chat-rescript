open Fastify
open Node
open Message

module Seed = {
  let getFakeChats = () => {
    let now = Date.getTime(Date.make())

    let chats: array<ToClient.t> = [
      {
        from: "GitHub Copilot",
        timestamp: now,
        message: "Have you guys seen those AI robots? They can do some crazy things!"
      },
      {
        from: "Bard",
        timestamp: now -. 12000.0,
        message: "Yeah, I heard they can even beat humans in chess."
      },
      {
        from: "ChatGPT",
        timestamp: now -. 30000.0,
        message: "Well, that's nothing. My AI assistant once translated \"I love you\" to \"Error 404: Romance not found.\"",
      }
    ]

    chats
  }
}

module Db = {
  let clients: Dict.t<WebSocket.t> = Dict.make()

  let chats: array<ToClient.t> = Seed.getFakeChats()
}

let getChatHistory = () => Array.copy(Db.chats)

let broadcast = (~payload, ~onError, ~exceptTo=?) => {
  switch ToClient.serializeOne(payload) {
    | Error(error) => onError(error)
    | Ok(message) => Db.clients
      -> Dict.toArray
      -> Array.forEach(((username, socket)) => {
        switch exceptTo {
          | None => socket->WebSocket.send(message)
          | Some(exceptTo) => {
            if username !== exceptTo {
              socket->WebSocket.send(message)
            }
          }
        }
      })
  }
}

let handleClient = (~username, ~socket, ~onError) => {
  Dict.set(Db.clients, username, socket)

  let payload = ToClient.create(
    ~from=ToClient.getServerUsername(),
    ~message=`${username} joined`,
  )

  broadcast(~payload, ~onError, ~exceptTo=username)

  socket->WebSocket.onMessage((buffer) => {
    let string = buffer->Buffer.toString
    let message = ToServer.deserialize(string)
    switch message {
      | Error(error) => onError(error)
      | Ok(message) => {
        let payload = ToClient.create(~from=username, ~message=message.message)

        Array.push(Db.chats, payload)

        broadcast(~payload, ~onError)
      }
    }
  })

  socket->WebSocket.onClose(() => {
    let payload = ToClient.create(
      ~from=ToClient.getServerUsername(),
      ~message=`${username} left`,
    )

    broadcast(~payload, ~onError, ~exceptTo=username)
  })
}

