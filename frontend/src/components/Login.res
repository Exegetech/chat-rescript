@react.component
let make = (~onSubmit: (string) => ()) => {
  let (text, setText) = React.useState(() => "")

  let handleKeyDown = (e) => {
    let key = ReactEvent.Keyboard.key(e)

    switch key {
      | "Enter" => {
        ReactEvent.Keyboard.preventDefault(e)

        onSubmit(text)
        setText((_) => "")
      } 
      | _ => ()
    }
  }

  let handleInputChange = (event) => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setText((_) => value)
  }

  let handleButtonClick = (_) => {
    switch text {
      | "" => () 
      | text => {
        onSubmit(text)
        setText((_) => "")
      }
    }
  }

  <div className="card bg-neutral text-neutral-content rounded-lg">
    <div className="card-body items-center text-center">
      <h2 className="card-title">{React.string("Welcome to Chat")}</h2>

      <input
        type_="text"
        placeholder="Create username"
        className="input input-bordered mr-1 w-full text-black"
        value={text}
        onChange={handleInputChange}
        onKeyDown={handleKeyDown}
      />

      <div className="card-actions justify-end">
        <button
          className="btn btn-primary"
          onClick={handleButtonClick}
        >
          {React.string("Login")}
        </button>
      </div>
    </div>
  </div>
}
