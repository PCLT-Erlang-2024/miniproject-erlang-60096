-module(conveyor_belt).
-export([start/1, loop/1]).

start(TruckPids) ->
    TruckStatus = [{TruckPid, true} || TruckPid <- TruckPids],
    spawn(?MODULE, loop, [TruckStatus]).

loop(TruckStatus) ->
    receive
        {new_package, Package} ->
            case lists:filter(fun({_, Available}) -> Available end, TruckStatus) of
                [] ->
                    io:format("Conveyor Belt ~p: No available trucks. Waiting...~n", [self()]),
                    loop(TruckStatus);
                AvailableTrucks ->
                    {RandomTruck, _} = lists:nth(
                        rand:uniform(length(AvailableTrucks)), AvailableTrucks
                    ),
                    RandomTruck ! {load_package, self(), Package},
                    io:format("Conveyor Belt ~p: Moved package ~p (size: ~p) to truck ~p~n", [
                        self(), element(2, Package), element(3, Package), RandomTruck
                    ]),
                    loop(TruckStatus)
            end;
        {truck_full, TruckPid} ->
            io:format("Conveyor Belt ~p: Truck ~p is full~n", [self(), TruckPid]),
            UpdatedTruckStatus = update_truck_status(TruckStatus, TruckPid, false),
            loop(UpdatedTruckStatus);
        {truck_available, TruckPid} ->
            io:format("Conveyor Belt ~p: Truck ~p is now available~n", [self(), TruckPid]),
            UpdatedTruckStatus = update_truck_status(TruckStatus, TruckPid, true),
            loop(UpdatedTruckStatus)
    end.

update_truck_status(TruckStatus, TruckPid, NewStatus) ->
    lists:map(
        fun
            ({Pid, _}) when Pid =:= TruckPid -> {Pid, NewStatus};
            (Entry) -> Entry
        end,
        TruckStatus
    ).
