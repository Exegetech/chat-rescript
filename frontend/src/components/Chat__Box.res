module Bubble = Chat__Bubble
module Input = Chat__Input

@react.component
let make = (
  ~chats: array<Message.ToClient.t>,
  ~currentUser: string,
  ~onSubmit: (string, string) => (),
) => {
  let bottomRef = React.useRef(Nullable.null)

  React.useEffect1(() => {
    switch Nullable.toOption(bottomRef.current) {
      | Some(dom) => dom->AppDom.scrollIntoView
      | None => ()
    }

    None
  }, [chats]);

  let usersColor = Util.makeUsersColorDict(currentUser, chats)

  let handleSubmit = (message) => {
    onSubmit(currentUser, message)
  }

  <div>
    <div className=`
      bg-slate-100
      p-4
      h-[40rem]
      overflow-y-scroll
      rounded-t-lg
    `>
      {Array.mapWithIndex(chats, (chat, idx) => {
        <Bubble
          key={Int.toString(idx)}
          usersColor
          currentUser
          chat
        />
      })->React.array}

      <div ref={ReactDOM.Ref.domRef(bottomRef)} />
    </div>

    <Input
      onSubmit={handleSubmit}
    />
  </div>
}

