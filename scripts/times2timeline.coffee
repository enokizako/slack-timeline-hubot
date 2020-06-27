# 自分のslackのURL
slack_url = "https://ptcod.slack.com"

module.exports = (robot) ->
  # どんな文字列があっても拾う
  robot.hear /.+/i, (msg) ->
    room = msg.envelope.room
    robot.adapter.client.web.conversations.info(msg.envelope.room).then((response) ->
      roomName = response.channel.name
      # times_ユーザ名の部屋だけウォッチ対象にする
      if roomName.match(/^times_.+/)
        # 展開可能なURLを作成し、タイムライン表示用の部屋に投稿する
        # roomの指定で、 投稿するchannelを指定
        # 第二引数でメッセージ内容を記述
        message_text = msg.envelope.message.text
        robot.send {room: "#timeline"}, "#{roomName}:\n #{message_text}"
    )
