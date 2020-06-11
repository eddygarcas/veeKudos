title = {
    type: "section",
    text: {
        type: "mrkdwn",
        text: "🤖 *Here your Kudos*. Send kudos to your colleagues using `/kudos @username text`"
    }
}
divider = {type: "divider"}

elems = @kudos.map.with_index do |elem, index|
  {
      type: "context",
      elements: [
      {
          type: "plain_text",
          text: "📢 *#{elem.sender} said:* \"#{elem.text}\"\n",
          emoji: true
      }]
  }
end

json.set! "blocks", [title, divider] + elems