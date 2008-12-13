-module(launch).
-export([start/2]).

start(AnAtom, Fun) ->
  psetup(whereis(AnAtom), AnAtom, Fun).

%% Start and register a process or just return the atom name of it.
psetup(undefined, AnAtom, Fun) ->
  register(AnAtom, spawn(Fun)),
  AnAtom;
psetup(_, AnAtom, _) ->
  AnAtom.
