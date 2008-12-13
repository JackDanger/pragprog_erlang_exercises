-module(ring).
-export([benchmark/2]).


benchmark(Times, Message) ->
  spawn(fun ringpass/0) ! {self(), Times, Message},
  receive
    {finished, Message} ->
      io:format("Finished sending ~p~n", [Message])
  end.


ringpass() ->
  receive
    {Parent, 1, Message} -> 
      io:format("Process: ~p received last count ~n", [self()]),
      Parent ! {finished, Message};
    {Parent, Times, Message} ->
      io:format("Process: ~p received count ~p~n", [self(),Times]),
      spawn(fun ringpass/0) ! {Parent, Times - 1, Message}
  end.
