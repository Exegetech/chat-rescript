// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Util from "../utils/Util.bs.mjs";
import * as React from "react";
import * as Caml_option from "rescript/lib/es6/caml_option.js";
import * as Chat__Input from "./Chat__Input.bs.mjs";
import * as Chat__Bubble from "./Chat__Bubble.bs.mjs";
import * as JsxRuntime from "react/jsx-runtime";

function Chat__Box(props) {
  var onSubmit = props.onSubmit;
  var currentUser = props.currentUser;
  var chats = props.chats;
  var bottomRef = React.useRef(null);
  React.useEffect((function () {
          var dom = bottomRef.current;
          if (!(dom == null)) {
            dom.scrollIntoView();
          }
          
        }), [chats]);
  var usersColor = Util.makeUsersColorDict(currentUser, chats);
  var handleSubmit = function (message) {
    onSubmit(currentUser, message);
  };
  return JsxRuntime.jsxs("div", {
              children: [
                JsxRuntime.jsxs("div", {
                      children: [
                        chats.map(function (chat, idx) {
                              return JsxRuntime.jsx(Chat__Bubble.make, {
                                          usersColor: usersColor,
                                          currentUser: currentUser,
                                          chat: chat
                                        }, idx.toString());
                            }),
                        JsxRuntime.jsx("div", {
                              ref: Caml_option.some(bottomRef)
                            })
                      ],
                      className: "\n      bg-slate-100\n      p-4\n      h-[40rem]\n      overflow-y-scroll\n      rounded-t-lg\n    "
                    }),
                JsxRuntime.jsx(Chat__Input.make, {
                      onSubmit: handleSubmit
                    })
              ]
            });
}

var make = Chat__Box;

export {
  make ,
}
/* react Not a pure module */