# 自分のslackのURL
slack_url = "https://ptcod.slack.com"

module.exports = (robot) ->
  # どんな文字列があっても拾う
  robot.hear /.+/i, (msg) ->
    room = msg.envelope.room    
    robot.adapter.client.web.conversations.info(msg.envelope.room).then((response) ->
      room_name = response.channel.name
      # times_ユーザ名の部屋だけウォッチ対象にする
      if room_name.match(/^times_.+/)
        message_text = msg.envelope.message.text
        # idにドットがあるとURLを展開してくれないので取り除く
        id = msg.message.id.replace(".","")
        user_id = msg.message.user.id
        display_name = robot.brain.data.users[user_id].slack.profile.display_name
        user_image = msg.message.user.slack.profile.image_48
        # roomの指定で、 投稿するchannelを指定
        robot.send({room: "#newbies"}, {
              as_user: false,
              username: "#{display_name}(BOT)",
              icon_url: "#{user_image}",
              text: "#{message_text}\n ( at <#{slack_url}/archives/#{room}/p#{id}|#{room_name}> )"
            });
    )