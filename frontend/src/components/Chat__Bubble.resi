@react.component
let make: (
  ~usersColor: Dict.t<string>,
  ~currentUser: string,
  ~chat: Message.ToClient.t,
) => Jsx.element
