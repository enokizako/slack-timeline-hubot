module.exports = (robot) ->
  robot.hear(/hello/i, (res) ->
    res.reply("hi")
  )
