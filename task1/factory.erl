-module(factory).
-export([start/5]).

start(NumPackages, NumBelts, NumTrucks, PackageSize, TruckCapacity) ->
    if
        PackageSize > TruckCapacity ->
            exit({error, "Package size cannot be greater than truck capacity"});
        true ->
            TruckPids = [truck:start(Index, TruckCapacity) || Index <- lists:seq(1, NumTrucks)],
            ConveyorPids = [conveyor_belt:start(TruckPids) || _ <- lists:seq(1, NumBelts)],
            package_generator:start(ConveyorPids, NumPackages, PackageSize),
            io:format(
                "Factory started with ~p packages of size ~p, ~p conveyor belts, ~p trucks, and truck capacity of ~p~n",
                [NumPackages, PackageSize, NumBelts, NumTrucks, TruckCapacity]
            )
    end.
