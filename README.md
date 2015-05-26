# Implementation of Hack computer architecture in VHDL

## Features

* Follows a similar structure to the implementation describe by the nand to tetris book
* 

## Tools

The creation of this software was made possible by the following open source tools and
libraries, and most notably, *Noam Nisan*, and *Shimon Schocken* who created the *Nand to
tetris* course and accompanying book "The Elements of Computing Systems, Building a Modern
Computer from First Principe's".

* [Gnu Emacs][], because there is no place like home; and no greater editor!
* [GHDL][], for VHDL compilation/simulation.

## License

This project is licensed under the [GPLv3][]. Please see the LICENSE file for full details.

## Building

    $ cd src
    $ ghdl -i --workdir=work *.vhdl
    $ ghdl -m --workdir=work <testbench> # simulate test bench of your choosing (eg. cpu_tb)

## Issues

Currently the chips called ROM, Screen, Keyboard, Memory and Computer in the *Nand to Tetris*
book are not implemented. The ROM chip is simply a RAM16k chip with no write capability (the
interface doesn't require a load bit). Computer and Memory are simply compositions of chips,
leaving the hard work left to implementing the screen and keyboard. I aim to complete this
via vga for the screen and PS2 for the keyboard, though I'm still in the process of research.

[Gnu Emacs]: http://www.gnu.org/software/emacs/
[GPLv3]: https://www.gnu.org/licenses/gpl.html
[GHDL]: http://ghdl.free.fr/
