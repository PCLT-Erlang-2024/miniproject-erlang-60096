-module(factory).
-export([start/6]).

start(NumPackages, NumBelts, NumTrucks, MinPackageSize, MaxPackageSize, TruckCapacity) ->
    if
        MinPackageSize > MaxPackageSize ->
            exit({error, "Min package size cannot be greater than max package size"});
        MaxPackageSize > TruckCapacity ->
            exit({error, "Max package size cannot be greater than truck capacity"});
        true ->
            TruckPids = [truck:start(Index, TruckCapacity) || Index <- lists:seq(1, NumTrucks)],
            ConveyorPids = [conveyor_belt:start(TruckPids) || _ <- lists:seq(1, NumBelts)],
            package_generator:start(ConveyorPids, NumPackages, MinPackageSize, MaxPackageSize),
            io:format(
                "Factory started with ~p packages, package size range [~p,~p], ~p conveyor belts, ~p trucks, and truck capacity of ~p~n",
                [NumPackages, MinPackageSize, MaxPackageSize, NumBelts, NumTrucks, TruckCapacity]
            )
    end.
