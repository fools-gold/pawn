# Description
#   Keep track of Elo ratings
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot elo (leaderboard|rankings) - Displays current Elo ratings
#   hubot elo <winner> (beat|won|defeated) <loser> - Updates Elo ratings of two players
#   hubot elo <player1> drew with <player2> - Updates Elo ratings of two players (ending in a draw)
#
# Author:
#   woongy

elo = (r1, s1, r2, s2, K = 32) ->
  q1 = Math.pow(10, r1 / 400)
  q2 = Math.pow(10, r2 / 400)

  e1 = q1 / (q1 + q2)
  e2 = q2 / (q1 + q2)

  [r1 + K * (s1 - e1), r2 + K * (s2 - e2)]

module.exports = (robot) ->

  robot.brain.data.elo ||= {}

  robot.respond /elo (leaderboard|rankings)/, (msg) ->
    players = ({ name: name, record: record } for name, record of robot.brain.data.elo)
    players.sort((a, b) -> b.record.rating - a.record.rating)

    msg.send players.map((player, index) ->
      "##{index+1} #{player.name} (#{Math.round(player.record.rating)}, #{player.record.wins}W #{player.record.losses}L)"
    ).join("\n")

  robot.respond /elo (.*) (beat|won|defeated) (.*)/, (msg) ->
    p1 = msg.match[1]
    p2 = msg.match[3]

    r1 = (robot.brain.data.elo[p1] ||= { wins: 0, losses: 0, draws: 0, rating: 1000 }).rating
    r2 = (robot.brain.data.elo[p2] ||= { wins: 0, losses: 0, draws: 0, rating: 1000 }).rating

    [robot.brain.data.elo[p1].rating, robot.brain.data.elo[p2].rating] = elo(r1, 1, r2, 0)

    robot.brain.data.elo[p1].wins += 1
    robot.brain.data.elo[p2].losses += 1

    msg.send "#{p1}: #{Math.round(r1)} -> #{Math.round(robot.brain.data.elo[p1].rating)}"
    msg.send "#{p2}: #{Math.round(r2)} -> #{Math.round(robot.brain.data.elo[p2].rating)}"

  robot.respond /elo (.*) drew with (.*)/, (msg) ->
    p1 = msg.match[1]
    p2 = msg.match[2]

    r1 = (robot.brain.data.elo[p1] ||= { wins: 0, losses: 0, draws: 0, rating: 1000 }).rating
    r2 = (robot.brain.data.elo[p2] ||= { wins: 0, losses: 0, draws: 0, rating: 1000 }).rating

    [robot.brain.data.elo[p1].rating, robot.brain.data.elo[p2].rating] = elo(r1, 0.5, r2, 0.5)

    robot.brain.data.elo[p1].draws += 1
    robot.brain.data.elo[p2].draws += 1

    msg.send "#{p1}: #{Math.round(r1)} -> #{Math.round(robot.brain.data.elo[p1].rating)}"
    msg.send "#{p2}: #{Math.round(r2)} -> #{Math.round(robot.brain.data.elo[p2].rating)}"
