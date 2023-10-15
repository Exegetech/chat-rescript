// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Util from "./utils/Util.bs.mjs";
import * as Login from "./components/Login.bs.mjs";
import * as React from "react";
import * as Message from "shared/src/Message.bs.mjs";
import * as Chat__Box from "./components/Chat__Box.bs.mjs";
import * as Caml_option from "rescript/lib/es6/caml_option.js";
import * as JsxRuntime from "react/jsx-runtime";

function App(props) {
  var match = React.useState(function () {
        return "";
      });
  var setUsername = match[1];
  var username = match[0];
  var match$1 = React.useState(function () {
        return [];
      });
  var setChats = match$1[1];
  var socket = React.useRef(undefined);
  React.useEffect((function () {
          var run = async function () {
            if (username === "") {
              return ;
            }
            var chatHistory = await Util.fetchChatHistory(username);
            if (chatHistory.TAG === "Ok") {
              var chatHistory$1 = chatHistory._0;
              setChats(function (_prev) {
                    return chatHistory$1;
                  });
            } else {
              console.error(chatHistory._0);
            }
            var url = "ws://localhost:3000/room?username=" + username;
            var ws = new WebSocket(url);
            ws.onopen = (function () {
                console.log("Connected to websocket");
              });
            ws.onmessage = (function ($$event) {
                var payload = Message.ToClient.deserializeOne($$event.data);
                if (payload.TAG === "Ok") {
                  var payload$1 = payload._0;
                  return setChats(function (prev) {
                              var newArr = prev.slice();
                              newArr.push(payload$1);
                              return newArr;
                            });
                }
                console.error(payload._0);
              });
            socket.current = Caml_option.some(ws);
          };
          run(undefined);
          return (function () {
                    var ws = socket.current;
                    if (ws !== undefined) {
                      Caml_option.valFromOption(ws).close();
                      return ;
                    }
                    
                  });
        }), [username]);
  var handleUsernameSubmit = function (username) {
    setUsername(function (_prev) {
          return username;
        });
  };
  var handleChatSubmit = function (from, message) {
    var ws = socket.current;
    if (ws === undefined) {
      return ;
    }
    var payload = Message.ToServer.serialize(Message.ToServer.create(from, message));
    if (payload.TAG === "Ok") {
      Caml_option.valFromOption(ws).send(payload._0);
      return ;
    }
    console.error(payload._0);
  };
  var tmp = username === "" ? JsxRuntime.jsx(Login.make, {
          onSubmit: handleUsernameSubmit
        }) : JsxRuntime.jsx(Chat__Box.make, {
          chats: match$1[0],
          currentUser: username,
          onSubmit: handleChatSubmit
        });
  return JsxRuntime.jsx("div", {
              children: JsxRuntime.jsx("div", {
                    children: tmp,
                    className: "mt-8"
                  }),
              className: "\n    container\n    mx-auto\n    h-screen\n    w-1/3\n    flex\n    flex-col\n  "
            });
}

var make = App;

export {
  make ,
}
/* Login Not a pure module */
