type status =
  | Pending
  | Delivered
  | Seen

let statusToString = (status: status): string => {
  switch status {
    | Pending => "Pending"
    | Delivered => "Delivered"
    | Seen => "Seen"
  }
}

type t = {
  username: string,
  updatedTime: string,
  status: status,
  text: string,
}

