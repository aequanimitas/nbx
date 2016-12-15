defmodule Nbx do
  require Logger

  def main(_args) do
    {_, json} = HTTPoison.get "http://data.nba.com/data/10s/v2015/json/mobile_teams/nba/2016/scores/00_todays_scores.json"
    xx = json.body |> JSON.decode!
    xx["gs"]["g"] 
    |> Enum.map(&Nbx.format_into/1)
    |> Enum.each(&Nbx.show_info/1)
  end

  def show_info(%{"HOME" => home, "WINNER" => winner, "VISITING" => visiting, "PERIOD" => period, "TIME_REMAINING" => time}) do
    IO.puts "-----"
    IO.puts home
    IO.puts visiting
    IO.puts period
    IO.puts time
    IO.puts winner
  end

  def format_into(game) do
    %{
      "HOME" => "HOME: #{game["h"]["tc"]} #{game["h"]["tn"]} - #{get_score(game, "h")}",
      "VISITING" => "VISITING: #{game["v"]["tc"]} #{game["v"]["tn"]} - #{get_score(game, "v")}",
      "PERIOD" => "PERIOD: #{game["stt"]}",
      "TIME_REMAINING" => "TIME REMAINING: #{game["cl"]}",
      "WINNER" => "WINNER: #{get_winner(game)}"
    }
  end

  def get_winner(game) do
    if get_score(game, "h") > get_score(game, "v") do
      game["h"]["tc"]
    else
      game["v"]["tc"]
    end
  end

  def get_score(game, key) do
    game[key]["s"]
  end
end
