% Copyright (c) 2012 the authors listed at the following URL, and/or
% the authors of referenced articles or incorporated external code:
% http://en.literateprograms.org/Selection_sort_(Erlang)?action=history&offset=20080418135230
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
% Retrieved from: http://en.literateprograms.org/Selection_sort_(Erlang)?oldid=13160

-module(ssort).
-export([sort/1]).

sort(L) when is_list(L) -> sort(L, []).

sort([], L) -> lists:reverse(L);

sort(L, Sorted) ->
    {Min, Rest} = remove_min(L),
    sort(Rest, [Min | Sorted]).

remove_min([H | T]) -> remove_min(T, H, []).

remove_min([], Min, Rest) -> { Min, Rest };

remove_min([H | T], Min, Rest) when H < Min ->
    remove_min(T, H, [Min | Rest]);

remove_min([H | T], Min, Rest) ->
    remove_min(T, Min, [H | Rest]).