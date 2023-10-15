let getChatHistory: () => array<Message.ToClient.t>

let handleClient: (
  ~username: string,
  ~socket: Fastify.WebSocket.t,
  ~onError: (string) => (),
) => ()

