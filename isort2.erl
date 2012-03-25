% Copyright (c) 2012 the authors listed at the following URL, and/or
% the authors of referenced articles or incorporated external code:
% http://en.literateprograms.org/Insertion_sort_(Erlang)?action=history&offset=20090419040816
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
% Retrieved from: http://en.literateprograms.org/Insertion_sort_(Erlang)?oldid=16401

-module(isort2).
-export([sort/1]).

sort(List) when is_list(List) ->
    sort(List, [], []).

sort([], Acc, _) ->
    lists:reverse(Acc);

sort(List = [X | _], [Y | AccT], Temp) when X < Y ->
    sort(List, AccT, [Y | Temp]);

sort([X | T], Acc, Temp) ->
    sort(T, lists:reverse(Temp) ++ [X | Acc], []).

