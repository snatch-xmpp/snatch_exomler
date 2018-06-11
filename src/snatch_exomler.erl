-module(snatch_exomler).
-author('manuel@altenwald.com').

-export([parse/1, encode/1]).

parse(Bytes) ->
    tr(exomler:decode(Bytes)).

encode(XML) ->
    exomler:encode(rt(XML)).

tr({Tag, Attrs, Children}) ->
    {xmlel, Tag, Attrs, tr(Children)};
tr(undefined) ->
    [];
tr([]) ->
    [];
tr(Bin) when is_binary(Bin) ->
    {xmlcdata, Bin}.

rt({xmlel, Tag, Attrs, Children}) ->
    {Tag, Attrs, rt(Children)};
rt([]) ->
    [];
rt({xmlcdata, CData}) ->
    CData.
