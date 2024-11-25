-module(conveyor_belt).
-export([start/1, loop/1]).

start(TruckPid) ->
    spawn(?MODULE, loop, [TruckPid]).

loop(TruckPid) ->
    receive
        {new_package, Package} ->
            TruckPid ! {load_package, self(), Package},
            io:format("Conveyor Belt ~p: Forwarded package ~p to truck~n", [self(), Package]),
            loop(TruckPid)
    end.
