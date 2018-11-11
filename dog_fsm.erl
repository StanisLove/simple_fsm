-module(dog_fsm).
-export([start/0, squirrel/1, pet/1]).

start() -> spawn(fun() -> bark() end).

squirrel(Pid) -> Pid ! squirrel.

pet(Pid) -> Pid ! pet.

bark() ->
  io:format("Dog say: 'Wof, wof'~n"),
  receive
    pet ->
      wag_tail();
    _ ->
      io:format("Dog confused~n"),
      bark()
  after 2000 ->
    bark()
  end.

wag_tail() ->
  io:format("Dog wagging tail~n"),
  receive
    pet ->
      sit();
    _ ->
      io:format("Dog confused~n"),
      wag_tail()
  after 30000 ->
    bark()
  end.

sit() ->
  io:format("Dog sitting~n"),
  receive
    squirrel ->
      bark();
    _ ->
      io:format("Dog confused~n"),
      sit()
  end.
