title = {
    type: "section",
    text: {
        type: "mrkdwn",
        text: "🤖 *Ranking* here you've got the ranking of Kudos!!"
    }
}
divider = {type: "divider"}

giv_sec = {
    type: "section",
    text: {
        type: "mrkdwn",
        text: "🎁 *People who gave more Kudos*"
    }
}

elems = @givers.map.with_index do |(key, value), index|
  {
      type: "section",
      text: {
          type: "mrkdwn",
          text: "#{key} #{index.eql?(0) ? "🥇" : index.eql?(1) ? "🥈" : index.eql?(2) ? "🥉" : "📜"}#{value} Kudos\n"
      }
  }
end

get_sec = {
    type: "section",
    text: {
        type: "mrkdwn",
        text: "🏆 *People who got more Kudos*"
    }
}

elems_g = @getters.map.with_index do |(key, value), index|
  {
      type: "section",
      text: {
          type: "mrkdwn",
          text: "#{key} #{index.eql?(0) ? "🥇" : index.eql?(1) ? "🥈" : index.eql?(2) ? "🥉" : "📜"}#{value} Kudos\n"
      }
  }
end

json.set! "blocks", [title, divider,giv_sec,elems,get_sec,elems_g].flatten