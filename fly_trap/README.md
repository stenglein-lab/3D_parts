This repository contains files used to create 3D-printed fruit fly traps.  These traps were designed by Shaun Cross, Mark Stenglein, and Lexi Keene-Snickers, and their use is described in [this paper](https://www.biorxiv.org/content/10.1101/2025.01.28.635319v1).  The 3D parts were designed in the [openscad scripting CAD language](https://openscad.org/).  Parts were mostly printed in PLA on a Lulzbot Taz 6 printer or a Prusa MK4 printer.  

Because the design files are parametric, it ought to be straightforward to modify these traps to fit on different size bottles or to modify other aspects of the traps.

### The design and print workflow was:

- Design parts in [openscad](https://openscad.org).
- Render part in openscad then export as STL file.
- Convert STL into printable gcode using [Cura Lulzbot edition](https://lulzbot.com/cura-lulzbot-edition) (Taz 6) or [Prusa Slicer](https://www.prusa3d.com/page/prusaslicer_424/) (MK4).  

### Trap variants

#### Standard trap

A standard trap, designed to fit on a small jar from uline (catalog #S-9934):

[SCAD file](./fly_trap-cap_Uline_S-9934.scad)

[a 3D-printed fly trap jar lid](./fly_trap-cap_Uline_S-9934.png)

#### The flyte house

A trap designed to look like the US White House.  Also fits on uline S-9934.

[SCAD file](./flyte_house.scad)

[a 3D-printed fly trap jar lid that looks like the white hosue](./flyte_house.png)


#### A platform to keep flies away from the bait

We bait these traps with banana and yeast or other kinds of bait.  This bait can liquify and get sticky and the flies can get stuck in the sticky goo.  We insert this platform into the jars to keep flies away from the bait.  We print the platform then hot glue on a piece of [organdy](https://en.wikipedia.org/wiki/Organdy) fabric.  We call this part the [pizza table](https://en.wikipedia.org/wiki/Pizza_saver).

[SCAD file](./pizza_table.scad]

[A platform to keep flies away from the sticky trap bait](./pizza_table.png)

#### A juice bottle version

This older version of the trap was designed to fit on 8 ounce juice bottles: uline catalog # [S-21725W](https://www.uline.com/Product/Detail/S-21725W). 

[SCAD file](./fly_trap-cap_Uline_S-21725W.scad)

[a 3D-printed fly trap juice bottle lid](./fly_trap-cap_Uline_S-21725W.png)






