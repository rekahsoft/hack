# Hack

* [Introduction](#introduction)
  * [Features](#features)
  * [Tools](#tools)
  * [License](#license)
* [Import VHDL Sources](#import-vhdl-sources)
* [Simulation](#simulation)
   * [Caveats](#simulation-caveats)
* [Issues](#issues)
* [Road Map](#road-map)
* [Wish List and Ideas For Extension](wish-list-and-ideas-for-extension)
* [Related Projects](#related-projects)

## Introduction <a name="introduction"></a>

Implementation of Hack Computer Architecture in VHDL. This implementation seeks to be
thoroughly verified through simulation using [GHDL][] and eventually implemented on a FPGA.

### Features <a name="features"></a>

* Follows a similar structure to the implementation describe by the *Nand to Tetris* book
* Uses open-source tools wherever possible

### Tools <a name="tools"></a>

The creation of this software was made possible by the following open source tools and
libraries, and most notably, *Noam Nisan*, and *Shimon Schocken* who created the *Nand to
Tetris* course and accompanying book *The Elements of Computing Systems, Building a Modern
Computer from First Principe's*.

* [Gnu Emacs][], because there is no place like home; and no greater editor!
* [GHDL][], for VHDL compilation/simulation.
* [GtkWave][], for viewing waveform dumps (vcd, fst, etc..)

### License <a name="license"></a>

This project is licensed under the [GPLv3][]. Please see the LICENSE file for full details.

## Import VHDL Sources <a name="import-vhdl-sources"></a>

    $ cd src
    $ ghdl -i --workdir=work *.vhdl

All units can then be built by building the top most unit, `computer_tb`, as follows.

    $ ghdl -m --workdir=work computer_tb.vhdl

## Simulation <a name="simulation"></a>

For every VHDL entity defined in `src` there is a accompanying test bench. The test bench has
`_tb` appended to the end of the entities file name (Eg. `cpu.vhdl` and `cpu_tb.vhdl`). Each test
bench consists of test data derived from the *Nand to Tetris* course. The simulated clock
(defined in `src/clock.vhdl` is set to a frequency of *1 GHz*, but this is configurable though
use of a generic property of the clock entity.

To run a test bench for a chip run the following:

    $ cd src
    $ ghdl -r --workdir=work adder_tb --vcd=wave/vcd/adder.vcd

The vcd output `wave/vcd/adder.vcd` can then be opened with [GtkWave][]. For convenience, pre-set
gtkwave views have been set up and can be loaded by using *File->Read Save File*.

There are two exceptions to the earlier statement about all VHDL entities having accompanying
test benches. Firstly there is a ROM entity for use in simulation only! It allows a text file
to act as a ROM chip, addressed by its line numbers. There is also an additional test bench
`src/computer_tb.vhdl`. This test bench simulates the computer as a whole, utilizing the ROM,
cpu, and ram16k entities. It has a generic property `program_file` that can be set to a *.hack*
file of your choosing, or if none is given it will use `src/asm/Fib.hack`. Example:

    $ cd src
    $ ghdl -r computer_tb -gprogram_file=asm/MemoryFill.hack --stop-time=10ns --vcd=wave/vcd/computer-memory-fill.vcd
    $ vcd2fst wave/vcd/computer-memory-fill.vcd wave/vcd/computer-memory-fill.fst

This will run a simulation for *10 ns* (for `computer_tb` a stop-time is required otherwise the
simulation will run forever) and output a vcd dump to `src/wave/vcd/computer-memory-fill.vcd`.
See `ghdl --help` and the [GHDL][] man page for more details on its command line options.

Another example, running the default `src/asm/Fib.hack` program:

    $ ghdl -r computer_tb --stop-time=750ns --vcd=wave/vcd/computer-fib.vcd
    $ vcd2fst wave/vcd/computer-fib.vcd wave/vcd/computer-fib.fst

Note that converting the vcd file to an fst file using vcd2fst is sometimes necessary when the
simulations become large. This mostly is the case with the `computer_tb` unit.

### Caveats <a name="simulation-caveats"></a>

Currently the `computer_tb` unit doesn't allow keyboard input or show monitor output; that is,
the memory maps are unimplemented as simulating the physical devices in VHDL is challenging,
and the implementation of them on actual hardware is dependent on the FPGA board being used.
The address ranges of the memory maps however, exist (*or rather will exist in a upcoming
commit*) and are read/writeable as you would expect (see the [issues](#issues) section for more
information).

The `computer_tb` unit also doesn't allow one to reset the system without explicitly modifying
the vhdl code of `computer_tb`. This could be fixed by implementing computer as its own entity
with one input (reset) for testing purposes. Then multiple test benches could be written to
test various aspects of the machine. Better yet, similar to how testing is done in the *Nand to
Tetris* course, we could have another generic property on the test bench to specify a 'compare
file' which could be used to compare the output of various signals from the implementation when
running a given program. This however, is currently not implemented.

Testing the output of a simulation (using `computer_tb`) of a given hack program also is not
implemented and is somewhat involved. 

The primitive screen could be implemented by doing txt dumps that represent the memory map at a
given point in time. Then an accompanying program could be written to parse this data and
generate a black and white image. Though this is not real time it would allow one to see some
visual feedback directly from a hack program using this simulation. I am quite new the VHDL, so
perhaps its easier to allow keyboard input during a simulation, but for the time being both the
keyboard and screen will remain unimplemented for simulation, though the simulator can still be
used to verify a hack program that affects screen works by looking at its writes to RAM.
However, when a keyboard is expected, this simulator runs as if no key on the keyboard is ever
pressed.

Additionally note that the RAM being used in simulation is RAM16k and does not include the
memory for the screen and keyboard memory maps. If any RAM address >= 0x4000 (or 16383 in
decimal), is read it will return 0x000 and if written will not retain its value. This I hope to
fix in the coming week, so viewing what a program does to the memory map and keyboards becomes
easier/feasible in [GtkWave][].

TLDR: `computer_tb` can be used to simulate any .hack program, though there is no screen or
keyboard connected, and the reset button during simulation unless the VHDL code of `computer_tb`
is modified to so.

## Issues <a name="issues"></a>

When simulating the computer using the `computer_tb` unit, the -g command line switch is only
available in very recent versions of [GHDL][] (later then 2015-03-07; see
[ticket](http://sourceforge.net/p/ghdl-updates/tickets/37/?limit=25)). Thus to run various
.hack programs in the simulation, one must edit the source file referenced in
`src/computer_tb.vhdl`.

When opening a vcd/fst dump of a program run in simulation using `computer_tb`, two template
[GtkWave][] save files are provided for convenience. These templates have the signals for the
clock, cpu, alu, registers A and D, as well as RAM[0] through RAM[100+]. This makes viewing the
output of a simulation easier, but in recent versions of [GHDL][], its generates different
labels when processing 'for ... generate' statements. To address this issue two [GtkWave][]
save files are provided, `src/wave/gtkw/computer.gtkw` is for the older version of [GtkWave][]
and `src/wave/gtkw/computer-ghdl-new.gtkw` is for the newer version (later then 2015-03-07).

If you discover a bug or have an issue with this project, please file a bug using
the [Rekahsoft flyspray powered bug tracker](https://bugs.rekahsoft.ca/index.php?project=7).

## Road Map <a name="road-map"></a>

Acquire an FPGA so that I can implement this design on real hardware. Currently I've been
leaning towards a
[Nexys 4 DDR](http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,1338&Prod=NEXYS4DDR)
or a [Basys 3](http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,1288&Prod=BASYS3).
Once I have an FPGA for testing I hope to implement the following features. Though it would be
nice to implement the simulation of the screen and keyboard but this seems nearly unfeasible,
and a better use of time would be to implement the design on real hardware.

* VGA output and associated memory map (perhaps find a backwards compatible way to add color to
  the system, support various VGA modes, etc..)
* Keyboard input and associated memory map (through USB or PS2)
* Use DDR memory or on-board FPGA RAM
* Use some onboard nonvolatile memory to store the ROM
* Implement an OS to be put on the ROM which can load programs, manage resources, etc..

### Wish List and Ideas for Extension <a name="wish-list-and-ideas-for-extension"></a>

* Modify the add16 unit to avoid
  [propagation delays](http://en.wikipedia.org/wiki/Propagation_delay) by passing a carry
  though out the addition of each bit
* Consider backwards compatible enhancements to the CPU; examples:
  - Make virtual registers internal registers
  - Make CPU 32 bit with backwards compatible 16 bit mode
  - Use bank switching to increase memory of 16 bit system
  - Implement a Memory Management Unit (MMU)
  - Others...

## Related Projects <a name="related-projects"></a>

To run a *Hack Assembly* program in the simulation it must be in its machine language
representation; that is it needs to be passed through an assembler. One such assembler is the
one provided with the *Nand to Tetris* course. I have also written another one, named `Asmblr`,
which is faster and more fully featured. For more information see the
[Asmblr](http://git.rekahsoft.ca/hackasm) repository and its accompanying
[README](http://git.rekahsoft.ca/hackasm/about).

[Gnu Emacs]: http://www.gnu.org/software/emacs/
[GPLv3]: https://www.gnu.org/licenses/gpl.html
[GHDL]: http://ghdl.free.fr/
[GtkWave]: http://gtkwave.sourceforge.net/
