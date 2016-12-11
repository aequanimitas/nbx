defmodule Nbx do
  require Logger

  def main(_args) do
    {_, json} = HTTPoison.get "http://data.nba.com/data/10s/v2015/json/mobile_teams/nba/2016/scores/00_todays_scores.json"
    xx = json.body |> JSON.decode!
    xx["gs"]["g"] 
    |> Enum.map(&Nbx.format_into/1)
    |> Enum.map(&Nbx.show_info/1)
  end

  def show_info(%{"GAME" => game, "SCORE" => score, "TIME_REMAINING" => time}) do
    IO.puts "-----"
    IO.puts game
    IO.puts score
    IO.puts time
  end

  def format_into(x) do
    %{
      "GAME" => "#{x["h"]["tc"]} #{x["h"]["tn"]} @ #{x["v"]["tc"]} #{x["v"]["tn"]}",
      "SCORE" => "#{x["h"]["s"]} - #{x["v"]["s"]} Period: #{x["stt"]}",
      "TIME_REMAINING" => "Time Remaining: #{x["cl"]}"
    }
  end
end
