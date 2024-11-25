-module(factory).
-export([start/5]).

start(NumPackages, NumBelts, NumTrucks, PackageSize, TruckCapacity) ->
    TruckPids = [truck:start(Index, TruckCapacity) || Index <- lists:seq(1, NumTrucks)],
    ConveyorPids = [conveyor_belt:start(TruckPids) || _ <- lists:seq(1, NumBelts)],
    PackageGenerator = package_generator:start(ConveyorPids, NumPackages, PackageSize),
    io:format(
        "Factory started with ~p packages of size ~p, ~p conveyor belt(s), ~p truck(s), and truck capacity of ~p~n",
        [NumPackages, PackageSize, NumBelts, NumTrucks, TruckCapacity]
    ),
    {ok, [PackageGenerator, ConveyorPids, TruckPids]}.
