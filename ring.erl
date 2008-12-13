-module(ring).
-export([benchmark/2]).


benchmark(Times, Message) ->
  L = lists:seq(1, Times),
  Pid = spawn(fun ringpass/0),
  Pid ! {self(), L, Message},
  receive
    {finished, Message} ->
      io:format("Finished sending ~p~n", [Message])
  end.


ringpass() ->
  receive
    {Parent, [H|T], Message} ->
      io:format("Process: ~p received count ~p~n", [self(),H]),
      spawn(fun ringpass/0) ! {Parent, T, Message};
    {Parent, [], Message} -> 
      io:format("Process: ~p received last count ~n", [self()]),
      Parent ! {finished, Message}
  end.
