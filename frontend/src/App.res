@react.component
let make = () => {
  let (chats, setChats) = React.useState(() => {
    let chats: array<Chat.t> = [
      {
        username: "Obi-Wan Kenobi",
        updatedTime: "2 hours ago",
        text: "You were the Chosen One!",
        status: Chat.Seen
      },
      {
        username: "Obi-Wan Kenobi",
        updatedTime: "2 hours ago",
        text: "I loved you",
        status: Chat.Delivered
      },
      {
        username: "Anakin",
        updatedTime: "12:46",
        text: "I hate you!",
        status: Chat.Seen,
      }
    ]

    chats
  })

  React.useEffect(() => {
    let username = "csakai"
    let url = `ws://localhost:3000/chat?username=${username}`
    let ws = Socket.createSocket(url)

    ws->Socket.set_onMessage((event) => {
      Console.log(event.data)
    })

    Some(() => ())
  })

  let handleInputSubmit = (_e) => {
    setChats((prev) => {
      let newArr = Array.copy(prev)
      Array.push(newArr, {
        username: "Anakin",
        updatedTime: "12:46",
        text: "I hate youuuuu!",
        status: Chat.Seen,
      })

      newArr
    })
  }

  <div className=`
    container
    mx-auto
    h-screen
    w-1/3
  `>
    <div className=`
      bg-slate-100
      p-4
      h-5/6
      overflow-y-scroll
    `>
      {Array.mapWithIndex(chats, (chat, idx) => {
        <Bubble
          key={Int.toString(idx)}
          isCurrentUser={false}
          chat={chat}
        />
      })->React.array}
    </div>

    <Input
      onSubmit={handleInputSubmit}
    />
  </div>
}
