title = {
    type: "section",
    text: {
        type: "mrkdwn",
        text: "🤖 *Kudos Leaders* here you've got the list of #{@commands[0].to_s} people of Kudos!!"
    }
}
divider = {type: "divider"}

elems = @kudos.map.with_index do |(key, value), index|
  {
      type: "section",
      text: {
          type: "mrkdwn",
          text: "#{key} #{index.eql?(0) ? "🥇" : index.eql?(1) ? "🥈" : index.eql?(2) ? "🥉" : "📜"}#{value} Kudos\n"
      }
  }
end
json.set! "blocks", [title, divider] + elems

