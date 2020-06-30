title = "🤖 Hey! *#{@kudo.sender.delete_prefix("@")}* gave a Kudo to *#{@kudo.receiver.delete_prefix("@")}* at ##{@kudo.channel_name} :clap:"
json.set! "text", title
