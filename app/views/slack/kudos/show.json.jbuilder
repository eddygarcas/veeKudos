title = {
    type: "section",
    text: {
        type: "mrkdwn",
        text: "🤖 *Here your Kudos*. Kudo the people who gave you one back!!"
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
          text: "*#{elem.sender} said:* \"#{sanitize(elem.text)}\"\n"
      }]
  }
end
json.set! "blocks", [title, divider,elems].flatten