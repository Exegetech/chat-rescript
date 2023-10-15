open Message

let fetchChatHistory = async (username) => {
  let url = `http://localhost:3000/chat?username=${username}`
  let response = await Fetch.fetch(url)
  let jsonString = await response->Fetch.Response.text 

  ToClient.deserializeMany(jsonString)
}

// https://tailwindcss.com/docs/content-configuration#dynamic-class-names
let getChatColor = (idx) => {
  let modded = mod(idx, 7)
  switch modded {
    | 0 => "chat-bubble-primary"
    | 1 => "chat-bubble-secondary"
    | 2 => "chat-bubble-accent"
    | 3 => "chat-bubble-info"
    | 4 => "chat-bubble-success"
    | 5 => "chat-bubble-warning"
    | _ => "chat-bubble-error"
  }
}

let makeUsersColorDict = (currentUser, chats) => {
  let dict = Dict.make()

  chats
    -> Array.map((chat) => chat.ToClient.from)
    -> Set.fromArray
    -> Set.values
    -> Iterator.toArray
    -> Array.forEachWithIndex((user, idx) => {
      let color = getChatColor(idx)
      if user === currentUser {
        Dict.set(dict, user, "chat-bubble")
      } else {
        Dict.set(dict, user, `chat-bubble ${color}`)
      }
    })

  dict
}

