@react.component
let make = (~isCurrentUser: bool, ~chat: Chat.t) => {
  let className = switch isCurrentUser {
    | true => "chat chat-end"
    | false => "chat chat-start"
  }

  <div className={className}>
    <div className="chat-header">
      {React.string(chat.username)}
      <time className="text-xs opacity-50">{React.string(chat.updatedTime)}</time>
    </div>
    <div className="chat-bubble">{React.string(chat.text)}</div>
    <div className="chat-footer opacity-50">
      {React.string(Chat.statusToString(chat.status))}
    </div>
  </div>
}
