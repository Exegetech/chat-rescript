open Message__JSON

type t = {
  from: string,
  message: string,
}

let create = (~from, ~message) => {
  let message = {
    from,
    message,
  }

  message
}

let serialize = (message) => {
  [
    ("from", String(message.from)),
    ("message", String(message.message)),
  ]
  -> Dict.fromArray
  -> Object
  -> stringify
}

let deserialize = (payload) => {
  switch parse(payload) {
    | Error(errMsg) => Error("Error parsing JSON: " ++ errMsg)
    | Ok(Object(dict)) => {
        let from = Dict.get(dict, "from")
        let message = Dict.get(dict, "message")

        switch (from, message) {
          | (
            Some(String(from)),
            Some(String(message)),
          ) if from !== "" && message !== "" => Ok({ from, message })
          | _ => Error("Expected non empty strings from and string message")
        }
      }
    | _ => Error("Expected an object")
  }
}

