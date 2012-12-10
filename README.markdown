Poker
=====

Poker hand evaluator

Written as an exercise in TDD, this gem is aimed at recognizing and comparing
poker hands.

Give it a poker hand like this :

    first_hand = PokeHerHand::Hand.new('AS AC AH AD KS')

And compare it with another like this :

    first_hand <=> PokeHerHand::Hand.new('9S 10S JS QS KS')

It will return exactly what you expect (-1, because the latter hand wins in
that case).

Easy isn't it ?

Boring Licence Stuff
--------------------

This is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see the LICENCE file or
[the official gpl page](http://www.gnu.org/licenses/)
