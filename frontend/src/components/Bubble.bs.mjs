// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Chat from "../models/Chat.bs.mjs";
import * as JsxRuntime from "react/jsx-runtime";

function Bubble(props) {
  var chat = props.chat;
  var className = props.isCurrentUser ? "chat chat-end" : "chat chat-start";
  return JsxRuntime.jsxs("div", {
              children: [
                JsxRuntime.jsxs("div", {
                      children: [
                        chat.username,
                        JsxRuntime.jsx("time", {
                              children: chat.updatedTime,
                              className: "text-xs opacity-50"
                            })
                      ],
                      className: "chat-header"
                    }),
                JsxRuntime.jsx("div", {
                      children: chat.text,
                      className: "chat-bubble"
                    }),
                JsxRuntime.jsx("div", {
                      children: Chat.statusToString(chat.status),
                      className: "chat-footer opacity-50"
                    })
              ],
              className: className
            });
}

var make = Bubble;

export {
  make ,
}
/* react/jsx-runtime Not a pure module */