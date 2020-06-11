json.response_type "in_channel"
title = {
    type: "section",
    text: {
        type: "mrkdwn",
        text: "🤖 Hey #{@kudo.receiver}! #{@kudo.sender.delete_prefix("@")} gave you a *Kudo!!* :clap: for..."
    }
}
divider = {type: "divider"}
message = {
    type: "section",
    text: {
        type: "mrkdwn",
        text: "👉 #{@kudo.text}"
    },
    accessory: {
        type: "image",
        image_url: "https://pbs.twimg.com/profile_images/625633822235693056/lNGUneLX_400x400.jpg",
        alt_text: "Kudo!"
    }
}
footer =  {
        "type": "context",
        "elements": [
            {
                "type": "plain_text",
                "text": "veeKudos by @eduard.garcia",
                "emoji": true
            }
        ]
    }

json.set! "blocks", [title,divider,message,divider,footer]