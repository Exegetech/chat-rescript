// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Message from "shared/src/Message.bs.mjs";

async function fetchChatHistory(username) {
  var url = "http://localhost:3000/chat?username=" + username;
  var response = await fetch(url);
  var jsonString = await response.text();
  return Message.ToClient.deserializeMany(jsonString);
}

function getChatColor(idx) {
  var modded = idx % 7;
  switch (modded) {
    case 0 :
        return "chat-bubble-primary";
    case 1 :
        return "chat-bubble-secondary";
    case 2 :
        return "chat-bubble-accent";
    case 3 :
        return "chat-bubble-info";
    case 4 :
        return "chat-bubble-success";
    case 5 :
        return "chat-bubble-warning";
    default:
      return "chat-bubble-error";
  }
}

function makeUsersColorDict(currentUser, chats) {
  var dict = {};
  Array.from(new Set(chats.map(function (chat) {
                    return chat.from;
                  })).values()).forEach(function (user, idx) {
        var color = getChatColor(idx);
        if (user === currentUser) {
          dict[user] = "chat-bubble";
        } else {
          dict[user] = "chat-bubble " + color;
        }
      });
  return dict;
}

export {
  fetchChatHistory ,
  makeUsersColorDict ,
}
/* No side effect */