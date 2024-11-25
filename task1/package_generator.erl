-module(package_generator).
-export([start/3, loop/4]).

start(Conveyors, NumPackages, PackageSize) ->
    spawn(?MODULE, loop, [Conveyors, NumPackages, 1, PackageSize]).

loop(_Conveyors, 0, _PackageId, _PackageSize) ->
    io:format("Package Generator: Finished creating packages~n"),
    ok;
loop(Conveyors, RemainingPackages, PackageId, PackageSize) ->
    Package = {package, PackageId, PackageSize},
    RandomConveyor = lists:nth(rand:uniform(length(Conveyors)), Conveyors),
    RandomConveyor ! {new_package, Package},
    io:format("Package Generator: Created package ~p of size ~p and sent to conveyor ~p~n", [
        PackageId, PackageSize, RandomConveyor
    ]),
    loop(Conveyors, RemainingPackages - 1, PackageId + 1, PackageSize).
