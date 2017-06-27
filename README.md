# ja-hires-life
Conway's Game of Life for unexpanded Jupiter Ace - "hi-res" version.

Where hi-res means a whopping 64x48 cells. That number of cells is quite a lot
to cram into an unexpanded Ace. I have had to cheat a bit and use the memory
set aside for the pad to store (some of) the cell store. It is actually pretty
slow despite the fact that there is not much Forth in this implementation. My
excuses for this are that it has four times as many cells as the low-res
version and extracting the state of cells from screen memory is
more awkward. I dare say if one were to lose the memory restriction, it would
be possible to make a zippier version that sacrifices memory for speed.

The file forth/life.ja4 is all that is required for the game. The asm folder
contains the source for the machine code sections in the forth file.

To run with an automatically generated starting position, use the word
"gen-life". Unfortunately there is no space for a designer with this one, so to
design your own starting position, issue the built-in words "invis cls" then
make use of the "plot" word to design your cell layout (x-coord y-coord 1 plot).
The bottom two rows are not available to the plot word with y coordinate 0 being
the third row from the bottom. Once the design is complete, use the word "life"
to start proceedings.
