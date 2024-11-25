-module(package_generator).
-export([start/4, loop/5]).

start(Conveyors, NumPackages, MinPackageSize, MaxPackageSize) ->
    spawn(?MODULE, loop, [Conveyors, NumPackages, 1, MinPackageSize, MaxPackageSize]).

loop(_Conveyors, 0, _PackageId, _MinPackageSize, _MaxPackageSize) ->
    io:format("Package Generator: Finished creating packages...~n"),
    ok;
loop(Conveyors, RemainingPackages, PackageId, MinPackageSize, MaxPackageSize) ->
    PackageSize = rand:uniform(MaxPackageSize - MinPackageSize + 1) + MinPackageSize - 1,
    Package = {package, PackageId, PackageSize},
    RandomConveyor = lists:nth(rand:uniform(length(Conveyors)), Conveyors),
    RandomConveyor ! {new_package, Package},
    io:format("Package Generator: Created package ~p of size ~p and sent to conveyor belt ~p~n", [
        PackageId, PackageSize, RandomConveyor
    ]),
    loop(Conveyors, RemainingPackages - 1, PackageId + 1, MinPackageSize, MaxPackageSize).
