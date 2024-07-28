# Frost Giants - Sparx Box
## Description
A box for organizing [Sparx](https://sparxhockey.com) grinding rings.

Based on this wonderful [OpenScad box](https://www.printables.com/model/648172-universal-parametric-rugged-box)

## Use
Look at output directory, and print ["top.stl"](output/top.stl), ["bottom.stl"](output/bottom.stl) and ["latch.stl"](output/latch.stl). 

If you use orca/bambu handy for slicing and want embedded text on the lid, ["top.3mf"](output/top.3mf) shows how I did it.

## Dev
Load open ["defaultbox.scad"](defaultbox.scad) into OpenScad. The most important things to be aware of:
- `View =` determines which view you get, look at the comment there for more info
- The disk holder logic is all in `module diskHolder()`. This contains all of the code for the inside of the bottom of the box