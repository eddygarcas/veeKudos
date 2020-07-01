title = "🤖 Hey! *#{@kudo.sender.delete_prefix("@")}* gave a Kudo to *#{@kudo.receiver.delete_prefix("@")}* on ##{@kudo.channel_name} :clap:"
json.set! "text", title
