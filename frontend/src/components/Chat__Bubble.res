@react.component
let make = (
  ~usersColor: Dict.t<string>,
  ~currentUser: string,
  ~chat: Message.ToClient.t,
) => {
  let dateString = chat.timestamp
    -> Date.fromTime
    -> Date.toLocaleString

  if chat.from === Message.ToClient.getServerUsername() {
    <div className="chat chat-start">
      <div className="chat-header">
        {React.string(chat.message)}

        <time className="text-xs opacity-50">
          {React.string(" " ++ dateString)}
        </time>
      </div>
    </div>
  } else {
    let className = if currentUser === chat.from {
      "chat chat-end"
    } else {
      "chat chat-start"
    }

    let colorClassName = usersColor
      -> Dict.get(chat.from)
      -> Option.getExn

    <div className={className}>
      <div className="chat-header">
        {React.string(chat.from)}

        <time className="text-xs opacity-50">
          {React.string(" " ++ dateString)}
        </time>
      </div>

      <div className={colorClassName}>
        {React.string(chat.message)}
      </div>
    </div>
  }
}
