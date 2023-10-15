// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Input from "./components/Input.bs.mjs";
import * as React from "react";
import * as Bubble from "./components/Bubble.bs.mjs";
import * as JsxRuntime from "react/jsx-runtime";

function App(props) {
  var match = React.useState(function () {
        return [
                {
                  username: "Obi-Wan Kenobi",
                  updatedTime: "2 hours ago",
                  status: "Seen",
                  text: "You were the Chosen One!"
                },
                {
                  username: "Obi-Wan Kenobi",
                  updatedTime: "2 hours ago",
                  status: "Delivered",
                  text: "I loved you"
                },
                {
                  username: "Anakin",
                  updatedTime: "12:46",
                  status: "Seen",
                  text: "I hate you!"
                }
              ];
      });
  var setChats = match[1];
  React.useEffect(function () {
        var url = "ws://localhost:3000/chat?username=csakai";
        var ws = new WebSocket(url);
        ws.onmessage = (function ($$event) {
            console.log($$event.data);
          });
        return (function () {
                  
                });
      });
  var handleInputSubmit = function (_e) {
    setChats(function (prev) {
          var newArr = prev.slice();
          newArr.push({
                username: "Anakin",
                updatedTime: "12:46",
                status: "Seen",
                text: "I hate youuuuu!"
              });
          return newArr;
        });
  };
  return JsxRuntime.jsxs("div", {
              children: [
                JsxRuntime.jsx("div", {
                      children: match[0].map(function (chat, idx) {
                            return JsxRuntime.jsx(Bubble.make, {
                                        isCurrentUser: false,
                                        chat: chat
                                      }, idx.toString());
                          }),
                      className: "\n      bg-slate-100\n      p-4\n      h-5/6\n      overflow-y-scroll\n    "
                    }),
                JsxRuntime.jsx(Input.make, {
                      onSubmit: handleInputSubmit
                    })
              ],
              className: "\n    container\n    mx-auto\n    h-screen\n    w-1/3\n  "
            });
}

var make = App;

export {
  make ,
}
/* Input Not a pure module */