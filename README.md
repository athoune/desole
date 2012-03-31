DeSoLe
======

Day-zo-lay, it ,means "sorry" in French.

DeSoLe is a toolkit for building DSL for Erlang.

Status
------

Early alpha.


Try it
------

_test1.dsl_ is a very simple example:

    a = 1+2;
    b = a * 3;
    c = b;

Lets compile it:

    $ ./private/desolec test1.dsl
    desole:run([], [desole_math, desole_stack], [
    {'fun', set, [ {atom, a}, {'fun', add, [{int, 1}, {int, 2}]}]},
    {'fun', set, [ {atom, b}, {'fun', times, [{'fun', get, [{atom, a}]}, {int, 3}]}]},
    {'fun', set, [ {atom, c}, {'fun', get, [{atom, b}]}]}])

Licence
-------

MIT ©Mathieu Lecarme 2012
