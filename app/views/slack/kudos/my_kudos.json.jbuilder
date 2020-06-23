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
          text: ":#{elem&.team_name&.downcase}: #{elem.sender} said at #{elem.channel_name}:  \"#{elem.text}\" on #{elem.created_at.strftime("%d/%m/%Y %H:%M")}\n",
          emoji: true
      }]
  }
end

json.set! "blocks", [title, divider] + elems