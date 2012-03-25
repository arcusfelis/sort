% Copyright (c) 2012 the authors listed at the following URL, and/or
% the authors of referenced articles or incorporated external code:
% http://en.literateprograms.org/Quicksort_(Erlang)?action=history&offset=20060711142841
% 
% Permission is hereby granted, free of charge, to any person obtaining
% a copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to
% permit persons to whom the Software is furnished to do so, subject to
% the following conditions:
% 
% The above copyright notice and this permission notice shall be
% included in all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
% CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
% TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
% 
% Retrieved from: http://en.literateprograms.org/Quicksort_(Erlang)?oldid=6960

-module(qsort).
-export([qsort1/1, qsort2/1, qsort3/1, qsort4/1]).

qsort1([]) ->
    [];
qsort1([H | T]) -> 
    qsort1([ X || X <- T, X < H ]) ++ [H] ++ qsort1([ X || X <- T, X >= H ]).

qsort2([]) ->
    [];
qsort2([H | T]) ->
    {Less, Equal, Greater} = part(H, T, {[], [H], []}),
    qsort2(Less) ++ Equal ++ qsort2(Greater).

part(_, [], {L, E, G}) ->
    {L, E, G};
part(X, [H | T], {L, E, G}) ->
    if
        H < X ->
            part(X, T, {[H | L], E, G});
        H > X ->
            part(X, T, {L, E, [H | G]});
        true ->
            part(X, T, {L, [H | E], G})
    end.


qsort3([]) ->
    [];
qsort3([H | T]) ->
    qsort3_acc([H | T], []).

qsort3_acc([], Acc) ->
    Acc;

qsort3_acc([H | T], Acc) ->
    part_acc(H, T, {[], [H], []}, Acc).

part_acc(_, [], {L, E, G}, Acc) ->
    qsort3_acc(L, (E ++ qsort3_acc(G, Acc)));
part_acc(X, [H | T], {L, E, G}, Acc) ->
    if
        H < X ->
            part_acc(X, T, {[H | L], E, G}, Acc);
        H > X ->
            part_acc(X, T, {L, E, [H | G]}, Acc);
        true ->
            part_acc(X, T, {L, [H | E], G}, Acc)
    end.




qsort4([]) ->
    [];
qsort4([H | T]) ->
    qsort4_acc([H | T], []).

qsort4_acc([], Acc) ->
    Acc;

qsort4_acc([H | T], Acc) ->
    qsort4_part_acc(H, T, [], [H], [], Acc).

qsort4_part_acc(_, [], L, E, G, Acc) ->
    qsort4_acc(L, (E ++ qsort4_acc(G, Acc)));
qsort4_part_acc(X, [H | T], L, E, G, Acc) ->
    if
        H < X ->
            qsort4_part_acc(X, T, [H | L], E, G, Acc);
        H > X ->
            qsort4_part_acc(X, T, L, E, [H | G], Acc);
        true ->
            qsort4_part_acc(X, T, L, [H | E], G, Acc)
    end.
