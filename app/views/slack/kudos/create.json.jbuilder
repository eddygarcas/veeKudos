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
        text: "#{VeeKudos.config[:company_emoji]} #{@kudo.text}"
    },
    accessory: {
        type: "image",
        image_url: "#{@image}",
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
            },
            {
                "type": "image",
                "image_url": "https://veekudos.herokuapp.com/giphy.png",
                "alt_text": "Powered by Giphy"
            }
        ]
    }

json.set! "blocks", [title,divider,message,divider,footer]