open Message

let fetchChatHistory: (string) => promise<result<array<ToClient.t>, string>>

let makeUsersColorDict: (string, array<ToClient.t>) => Dict.t<string>
