===========================================================================
tinyQCC - Advanced QuakeC Compiler
===========================================================================

This is a modernized, heavily optimized fork of the original 1996 QuakeC 
compiler. 

When John Carmack originally released qcc's source, he noted that the 
QCC compiler was rushed, lacked quality engineering time, and generated 
"horribly naive and space inefficient" bytecode. While the vanilla bytecode
compiled at approximately 410.6 kilobytes, the same code ran through THIS
compiler compiled at 366.3 kilobytes, and allows the engine to do less math
and behind-the-scenes work, making the renderer a bit smoother in some cases.

This updated compiler was built to fix that, amongst other various fixes.
It's designed to be a lean utilitythat generates optimized progs.dat files 
and remains 100% compatible with the PROG_VERSION 6 file specification.
In short, it's dragging QCC kicking and screaming into the modern era,
as far as efficiency and modern memory saving techniques are concerned.

Major optimizations and features include:

* String Deduplication: A string pool ensures that repeated string literals 
  (like sound paths or classnames) are only written to the binary once, 
  drastically reducing file size.
* Constant Folding: Vector and float arithmetic on constants (e.g., '100 0 0' * 5) 
  is evaluated at compile-time, saving the engine from calculating static math 
  at runtime.
* Dead Code Stripping: Unreferenced global variables and unused functions 
  are aggressively stripped from the final metadata, creating a much leaner 
  memory footprint for massive mods.
* Control Flow Optimization: Jump threading and dead store elimination bypass 
  redundant GOTO chains and clean up temporary compiler variables.
* Auto-Prototyping: Running with the `-autoprotos` flag performs a pre-pass 
  that automatically registers function signatures, eliminating the need to 
  manually declare forward prototypes in defs.qc.

---------------------------------------------------------------------------
HOW TO USE QCC
---------------------------------------------------------------------------
To modify the Quake program code, set up a new game directory parallel with 
id1, containing a "progs" subdirectory. 

If you can download a copy of the Quake 1.06 QuakeC codebase, this is a great
place to start analyzing and deconstructing what the game logic is handling.
Updated user-managed forks of the codebase are more likely to have less errors.
Copy all of your .qc files and your progs.src into that directory, and then 
run qcc from there. It will compile the files listed in progs.src and (if there
aren't any errors) generate a new progs.dat file in the parent directory
(or wherever you have pathed the binary in progs.src).

As a simple test, open the weapons.qc file, go to the ImpulseCommands function 
towards the EOF, write a function or two to enact some game logic once executed,
and tie those to an unused impulse number (up to 255) in the if statement list.
As an example, if you tied a command to number 100, typing `impulse 100` into the
console would then automatically execute the defined function exactly as written!


The directory structure will look something like this:

/quake/quake.exe
/quake/id1/
/quake/mygame/progs.dat
/quake/mygame/progs/progs.src
/quake/mygame/progs/world.qc
/quake/mygame/progs/client.qc
/quake/mygame/progs/... etc ...

Run your engine with "-game mygame", which will cause it to look for data 
in the mygame directory before falling back to id1. In this example, it will 
find the new progs.dat from mygame, and take everything else from id1. This
allows mods to be packaged and self-contained without distributing duplicate
or copyrighted assets.

---------------------------------------------------------------------------
DOCUMENTATION
---------------------------------------------------------------------------
The header `qcc.h` contains the language spec and underlying data structures.
The only true documentation for the various builtin engine functions is the 
source code used by the engine itself (see builtin.c). Some of them are 
required to do things outside the scope of the QCVM, and some are just 
there for speed reasons.

Internal Testing Specifications:
- Lenovo 80UD
- Arch Linux
- DOSBox 0.74-3
- Default DOSBox.conf

Happy compiling!

Pup Luka
Aerox Software
