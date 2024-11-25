-module(truck).
-export([start/1, loop/2]).

start(TruckId) ->
    Capacity = 50,
    spawn(?MODULE, loop, [TruckId, Capacity]).

loop(TruckId, RemainingCapacity) ->
    receive
        {load_package, ConveyorPid, {package, PackageId, PackageSize}} ->
            case PackageSize =< RemainingCapacity of
                true ->
                    NewCapacity = RemainingCapacity - PackageSize,
                    io:format("Truck ~p loaded package ~p (size: ~p). Remaining capacity: ~p~n", [
                        TruckId, PackageId, PackageSize, NewCapacity
                    ]),
                    loop(TruckId, NewCapacity);
                false ->
                    ConveyorPid ! {truck_full, self()},
                    io:format("Truck ~p is full. Resetting...~n", [TruckId]),
                    io:format("Truck ~p replaced and is now available.~n", [TruckId]),
                    ConveyorPid ! {truck_available, self()},
                    self() ! {load_package, ConveyorPid, {package, PackageId, PackageSize}},
                    loop(TruckId, 50)
            end
    end.
