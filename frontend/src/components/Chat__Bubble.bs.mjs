// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Message from "shared/src/Message.bs.mjs";
import * as Core__Option from "@rescript/core/src/Core__Option.bs.mjs";
import * as JsxRuntime from "react/jsx-runtime";

function Chat__Bubble(props) {
  var chat = props.chat;
  var dateString = new Date(chat.timestamp).toLocaleString();
  if (chat.from === Message.ToClient.getServerUsername(undefined)) {
    return JsxRuntime.jsx("div", {
                children: JsxRuntime.jsxs("div", {
                      children: [
                        chat.message,
                        JsxRuntime.jsx("time", {
                              children: " " + dateString,
                              className: "text-xs opacity-50"
                            })
                      ],
                      className: "chat-header"
                    }),
                className: "chat chat-start"
              });
  }
  var className = props.currentUser === chat.from ? "chat chat-end" : "chat chat-start";
  var colorClassName = Core__Option.getExn(props.usersColor[chat.from]);
  return JsxRuntime.jsxs("div", {
              children: [
                JsxRuntime.jsxs("div", {
                      children: [
                        chat.from,
                        JsxRuntime.jsx("time", {
                              children: " " + dateString,
                              className: "text-xs opacity-50"
                            })
                      ],
                      className: "chat-header"
                    }),
                JsxRuntime.jsx("div", {
                      children: chat.message,
                      className: colorClassName
                    })
              ],
              className: className
            });
}

var make = Chat__Bubble;

export {
  make ,
}
/* react/jsx-runtime Not a pure module */