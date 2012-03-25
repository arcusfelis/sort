-module(data).
-export([generate/2]).

generate(0, _) -> [];
generate(Cnt, Max) -> [random:uniform(Max) | generate(Cnt-1, Max)].
