@react.component
let make: (
  ~chats: array<Message.ToClient.t>,
  ~currentUser: string,
  ~onSubmit: (string, string) => (),
) => Jsx.element
