-module(factory).
-export([start/4]).

start(NumPackages, NumBelts, NumTrucks, PackageSize) ->
    TruckPids = [truck:start(Index) || Index <- lists:seq(1, NumTrucks)],
    ConveyorPids = [
        conveyor_belt:start(lists:nth((Index rem NumTrucks) + 1, TruckPids))
     || Index <- lists:seq(1, NumBelts)
    ],
    PackageGenerator = package_generator:start(ConveyorPids, NumPackages, PackageSize),
    io:format(
        "Factory started with ~p package(s) of size ~p, ~p conveyor belt(s), and ~p truck(s)~n",
        [NumPackages, PackageSize, NumBelts, NumTrucks]
    ),
    {ok, [PackageGenerator, ConveyorPids, TruckPids]}.
