-module(bench).
-export([bench/0]).

bench() ->
    [ bench(N) || N <- [500, 10, 100] ].


bench(N) ->
    io:format("~2nNumber of elements: ~B~n", [N]),
    Max = 10000,
    Data = data:generate(N, Max),
    SData = lists:sort(Data),
    Funs = [ fun lists:sort/1
           , fun bsort:sort/1
           , fun qsort:qsort1/1
           , fun qsort:qsort2/1
           , fun qsort:qsort3/1
           , fun qsort:qsort4/1
           , fun isort:sort/1
           , fun isort2:sort/1
           , fun ssort:sort/1
           , fun ssort2:sort/1
           ],
    %% make VM hotter
    measure(Data, SData),
    measure2(Data, SData),
    M1 = measure(Data, SData),
    M2 = measure2(Data, SData),
    Cases = [M1, M2],
    [ C(F) || C <- Cases, F <- Funs ].


measure(Data, SData) ->
    fun(F) ->
        Time = time(F, Data),
        STime = time(F, SData),
        io:format("Sort ~-25s: T1=~17B T2=~17B~n", 
            [io_lib:write(F), Time, STime])
    end.


measure2(Data, SData) ->
    Idol = fun lists:sort/1,
    IdolTime  = time(Idol, Data),
    IdolSTime = time(Idol, SData),
    fun(F) ->
        Time  = time(F, Data) / IdolTime,
        STime = time(F, SData) / IdolSTime,
        io:format("Sort ~-25s: T1/I=~15f T2/I=~15f~n", 
            [io_lib:write(F), Time, STime])
    end.


avg(L) -> erlang:round(lists:sum(L) / string:len(L)).


time(F, Data) -> 
    [_, _|T] = cycle(12, time_hof(F, Data)),
    avg(T).


time_hof(F, Data) -> 
    fun() ->
        {Time, _Res} = timer:tc(fun() -> F(Data) end), 
        Time
    end.


cycle(N, F) -> cycle(N, F, []).

cycle(0, _, Acc) -> Acc;
cycle(N, F, Acc) -> cycle(N-1, F, [F()|Acc]).
