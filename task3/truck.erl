-module(truck).
-export([start/2, loop/3]).
-define(MAX_DELAY_MS, 1000).

start(TruckId, Capacity) ->
    spawn(?MODULE, loop, [TruckId, Capacity, Capacity]).

loop(TruckId, RemainingCapacity, OriginalCapacity) ->
    receive
        {load_package, ConveyorPid, {package, PackageId, PackageSize}} ->
            case PackageSize =< RemainingCapacity of
                true ->
                    NewCapacity = RemainingCapacity - PackageSize,
                    io:format("Truck ~p loaded package ~p (size: ~p). Remaining capacity: ~p~n", [
                        self(), PackageId, PackageSize, NewCapacity
                    ]),
                    loop(TruckId, NewCapacity, OriginalCapacity);
                false ->
                    ConveyorPid ! {truck_full, self()},
                    io:format("Truck ~p is full. Replacing with a new truck...~n", [self()]),
                    random_delay(),
                    io:format("Truck ~p is available again.~n", [self()]),
                    ConveyorPid ! {truck_available, self()},
                    self() ! {load_package, ConveyorPid, {package, PackageId, PackageSize}},
                    loop(TruckId, OriginalCapacity, OriginalCapacity)
            end
    end.

random_delay() ->
    rand:uniform(?MAX_DELAY_MS).
