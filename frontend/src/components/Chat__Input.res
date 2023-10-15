@react.component
let make = (~onSubmit: (string) => unit) => {
  let (text, setText) = React.useState(() => "")

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

  let handleKeyDown = (e) => {
    let key = ReactEvent.Keyboard.key(e)

    switch (text, key) {
      | (text, "Enter") if text !== "" => {
        ReactEvent.Keyboard.preventDefault(e)

        onSubmit(text)
        setText((_) => "")
      } 
      | _ => ()
    }
  }

  <div className=`
    bg-slate-400
    p-2
    flex
    rounded-b-lg
  `>
    <input
      type_="text"
      placeholder="Type here"
      className="input input-bordered mr-1 w-full"
      value={text}
      onChange={handleInputChange}
      onKeyDown={handleKeyDown}
    />

    <button
      className="btn btn-square"
      onClick={handleButtonClick}
    >
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill="currentColor" d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576L6.636 10.07Zm6.787-8.201L1.591 6.602l4.339 2.76l7.494-7.493Z"/></svg>
    </button>
  </div>
}
