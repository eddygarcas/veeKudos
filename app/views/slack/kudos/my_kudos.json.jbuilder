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
              "type": "image",
              "image_url": "https://pbs.twimg.com/profile_images/625633822235693056/lNGUneLX_400x400.jpg",
              "alt_text": "cute cat"
          },
          {
          type: "mrkdwn",
          text: "*#{elem.sender} said:* \"#{elem.text}\"\n"
      }]
  }
end
json.set! "blocks", [title, divider] + elems