defmodule Nbx do
  require Logger

  def main(args) do
    {_, json} = HTTPoison.get "http://data.nba.com/data/10s/v2015/json/mobile_teams/nba/2016/scores/00_todays_scores.json"
    xx = json.body |> JSON.decode!
    xx["gs"]["g"] 
    |> Enum.map(&Nbx.format_into/1)
    |> Enum.join(" ***** ")
    |> inspect(pretty: true) 
    |> Logger.info
  end

  def format_into(x) do
    "#{x["h"]["tc"]} #{x["h"]["tn"]} @ #{x["v"]["tc"]} #{x["v"]["tn"]} Scores: #{x["h"]["s"]} - #{x["v"]["s"]} Period: #{x["stt"]} Time Remaining: #{x["cl"]}"  
  end
end
