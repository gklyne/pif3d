<font size='5'><b>Skeinforge version 46 parameters for use with Gen6 Electronics</b></font>

This page is intended for collecting notes for using Skeinforge\_46 to generate GCode files for RepRap using Mendel-parts Gen6 electronics and firmware.



I have successfully printed objects using parameters described here with Skeinforge version 46, but I am still tuning parameter values.  Compared with Skeinforge 41, the print head seems to move more rapidly using the same speed values, but I don't have measurements to back up this impression.  Consequently, I am turning down the speed settings to reduce stress on the print mechanics.

See also [Skeinforge\_Gen6\_Tuning](Skeinforge_Gen6_Tuning.md), which is the original version of this page developed for Skeinforge\_41.

For information about recent updates (latter part of 2011), see also:
  * http://fabmetheus.blogspot.com/2011/11/smooth.html
  * http://fabmetheus.blogspot.com/2011/09/skin.html

## Skeinforge ##

There is a fairly comprehensive and up-to-date Skeinforge manual, covering most or all of the settings in recent versions:
  * http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge

## Skeinforge parameters ##

The starting point for my Skeinforge\_46 tuning comes from the earlier page noted above.

_NOTE: this is currently in development, and may not yet fully reflect Skeinforge\_46 options_

Range values shown are given as a rough suggestion only, and indicate values that I have used with some success.

### Profile ###

  * Profile type – Extrusion
  * Profile selection – PLA (Note it is possible to create new profiles)

### Craft > Alteration ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Bottom

  * Activate Alteration - yes  (defaut: yes)

These parameters were previously under the preface tab:

  * Name of end file – end.gcode
  * Name of start file – start.gcode

New parameters:
  * Remove redundant Mcode - (defaut: yes)
  * Replace variable with setting - (default: yes)

The files containing start and end codes are kept in the Skeinforge `skeinforge_application/alterations` folder.  (The documentation incorrectly says the start and end codes are kept in the `alterations` folder in the `.skeinforge` folder in the home directory).

start.code - includes code to prime extruder head:
```
G28;                   Home X, Y and Z
G21;                   Metric
G90;                   Absolute positioning
G92 X0 Y0 Z0 E0;       Zero the extruded length axes
T0;                    Select extruder
G1 F250;               Feed rate
;G0 X0 Y0 Z0;           Home
;G92 E0;                Zero extruded length again
;G0 X5 Y5 Z0.5;         Position to prime extruder
;G1 X77 Y5 E2;          Primne extruder (note 36:1 extrusion:filament ratio)
;G1 E-0.01;             Withdraw filamanet slightly to reduce splodge at start
;G92 E0;                Zero extruded length again
```

end.gcode:
```
G91;          Relative positioning
G1 F70;       (Not sure why)
G1 Z7 F70;    Lifts nozzle 7mm from finished print surface
G90;          Absolute positioning
G0 X125 Y0;   Move nozzle over purge area
M104 S0;      Turns off extruder heater
```

### Craft > Bottom ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Bottom

  * Activate Bottom – Yes
  * Additional height over layer thickness (ratio) - 0.5 (range 0.2-0.5)
    * This parameter increases the height of the print head over the base when printing the first layer.  I'm not sure how it affects subsequent layers.  My Z=0 height is probably on the high side, so I find setting a smaller value for this parameter gives a cleaner first layer (coupled with slower feed rate for the first layer: see Raft settings).
    * Instead of adjusting this, change setting of Operating Nozzle Lift over Layer Thickness in Raft?
    * Optimum value may vary with printer setup, esp. Z-axis zero height.  I make final adjustments by adjusting the Z-axis zero height mechanically using the sensor screw adjustment.
  * Altitude (mm) - 0.0
    * "Sets bottom of carving to defined altitude" - http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Bottom. Maybe it is this parameter that should be adjusted to compensate for the initial Z-offset?
  * SVG viewer - webbrowser

### Craft > Carve ###

See; http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Carve

This is described as "the most important plugin to define for your printer".

  * Add layer template to SVG – Yes
  * Extra decimal places (float) 2.0
  * Import coarseness (ratio) 1.0
  * Layer thickness (mm) 0.4

-Layers-
  * Layers from (index) 0
  * Layers to (index) 912345678

  * Mesh type correct mesh – Yes

  * Perimeter width over thickness (ratio) - 1.8 (range: 1.5 - 1.8, default: 1.8)
    * "how thick the perimeter wall will be in relation to the layer thickness. Default value of 1.8 for default thickness of 0.4 states that single filament perimeter wall will be 0.4x1.8=0.72mm thick. This is an important calibration value. You need to be sure that speed of the head and extrusion rate in combination produce walls that are layer thickness x perimeter width over thickness thick" -- http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Carve.
    * Suggests to me that a value closer to 1.5 might be better, as my skirt comes out 0.5x0.5, which is very close to 0.4x0.6.  It does seem to be working well, along with the other settings.
    * I later increased this value to 1.7 as the solid infill areas seemed to be "overpopulated", and later caliper measurements of single-filament tracks were 0.4\*0.7 or 0.4\*0.8.

### Craft > Chamber ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Chamber

  * Activate chamber – No

### Craft > Clip ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Clip

Clips the ends of loops to prevent bumps from forming

  * Activate clip – Yes
  * Clip over perimeter width (ratio) - 0.5 (default: 0.5)
    * "Defines the ratio of the amount each end of the loop is clipped over the perimeter width. The total gap will therefore be twice the clip. If the ratio is too high loops will have a gap, if the ratio is too low there will be a bulge at the loop ends." -- http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Clip
    * _Gary76_ was using 0.5, but I found this was leaving gaps in the loops.  The original default was 0.15.
    * I was getting perimeter bulging at 0.15, so am increasing this again to the default value
  * Maximum connection distance over perimeter width (ratio) - 10.0
    * Skeinforge tries to form loops that are closer than this value (as mulktiple of perimeter width) in a single extrusion.

### Craft > Comb ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Comb

  * Activate - Yes
    * Previously not used, but on reading the description it looks like a good feature to use.
  * Running jump space (mm) - 0 (default: 2.0)
    * Apparently, non-zero values only helpful if the firmware uses accelerating movements.

### Craft > Cool ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Cool

  * Activate – Yes
  * Cool type: slow down
  * Minimum time per layer - 60s (default: 60)

Other parameters relate to temperature control, which I'm not currently using.  Past experience suggests that delays introduced for cooling, with the attendant oozing, cause more problems than having a sub-optimal temperature.

### Craft > Dimension ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Dimension

This is described as "5D option for skeinforge".

  * Activate dimension – Yes
  * Absolute extrusion distance – Yes
  * Extruder retraction speed (mm/s) - 30.0 (down from 50)

-Filament-
  * Filament diameter (mm) 2.9 (measured with dial caliper) (range: 2.8 - 3.0)
  * Filament packing density (ratio) 0.97 (default: 0.85 is for ABS)
    * Adjusts for extruder teeth digging into the filament and hence causing lower feed rate
  * Maximum E Value before reset - (default 91234.0)
  * Minimum travel for retraction - (default 1.0)
  * Retract within island - (default: no)
  * Retraction distance (mm) 2.0 (default: 0, range: 1.0 - 3.0)
    * Documentation suggests 10.  May want to try a larger value.  But (according to a post I read somewhere) if air is drawn into the chamber, this may cause oxidation of the plastic and a build-up of residue that can clog the extruder.  I think 5mm was suggested as a maximum value.
  * Restart extra distance (mm) -0.04 (range: -0.01 - -0.05)
    * _Gary76_ was using 0.5, but I found this left large gaps in the build (later: this may have been caused by separate extruder probems)
    * I tried 0, and that was much better, but did tend to leave a few splodges at the start of internal runs.  I tried -0.05, but at that setting, the initial perimeter track did not stick to the base plate (though apart from that the print was very good.
    * At -0.03, with a rebuilt extruder, print quality is OK  I am getting some splodges at start of runs: maybe need to try -0.04 or -0.05 again?

### Craft > Export ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Export

  * Activate export – Yes
  * Add export suffix – Yes
  * Gcode small – Yes (default: do not change output)

  * Name of replace file - replace.csv

The `replace.csv` file is located in the Skeinforge `skeinforge_application/alterations` folder, and has the following content:
```
M101	;M101
M103	;M103
M108	;M108
```

### Craft > Fill ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Fill

  * Activate fill – Yes

-Diaphragm-
  * Diaphragm period (layers) - 100
  * Diaphragm thickness (layers) - 0

-Extra shells-
  * Extra shells on alternating solid layer (layers) - 2 (default: 2)
    * "Extra Shells - Shell is the "outline" extrusion. You can set different number for these outlines on alternating layers" -- http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Fill
    * Default value - not sure of purpose, unless to create some extra bonding between shell and infill.
  * Extra shells on base (layers) - 1 (default: 1)
    * Tried 2, per http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Fill, but this left very little surface infill on small piece.  1 is OK if it sticks well to the print base.
  * Extra shells on sparse layer (layers) - 1 (default: 1)

-Grid-
  * Grid circle separation over perimeter width (ratio) - 0.2
  * Grid extra overlap (ratio) - 0.1
    * "This appears to have no effect if line is chosen as the infill pattern. Look at infill width over thickness if using line as the infill pattern".
  * Grid junction separation band height (layers) - 10 (?)
  * Grid junction separation over octagon radios at end (ratio) - 0.0 (?)
  * Grid junction separation over octagon radios at middle (ratio) - 0.0 (?)

-Infill-
  * Infill begin rotation (degrees) - 45.0
  * Infill begin rotation repeat (layers) - 1
  * Infill odd layer extra rotation (degrees) - 90.0
  * Line – Yes
  * Infill perimeter overlap (ratio) - 0.15 (default: 0.15, was: 0.2)
    * "Defines how much overlap there is between the infill pattern and perimeter loops. 0 means that the infill barely touches the perimeter, 1 gives an overlap of one complete extrusion width. A value of slightly more then 0 is recommended for a good bonding of the two" -- http://wiki.bitsfrombytes.com/index.php/Skeinforge_Fill#Infill_Perimeter_Overlap_.28ratio.29
  * Infill solidity - 0.2
  * Infill width over thickness (ratio) - 1.5
    * Seems to control the density at which infill is laid down.  E.g. see http://www.bitsfrombytes.com/forum/post/infill-width-over-thickness
  * Solid surface thickness (layers) - 3

### Craft > Fillet ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Fillet

  * Activate – No

### Craft > Home ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Home

  * Activate – No (default: yes)

### Craft > Hop ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Hop

  * Activate – No

### Craft > Inset ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Inset

This appears to be very different from previous versions.  There is no overall activation option, so options are selected individually:

  * Add custom code for temperature reading - No (default: yes)
    * Set to "No" as I am currently using constant temperature controlled by the controller board.
  * Infill in direction of bridge - (default - yes)
  * Loop porder choice - (default: ascending area)
  * Overlap removal width over perimeter width - (default 0.6)
  * Turn heater off at shutdown - Yes

### Craft > Jitter ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Jitter

  * Activate – No (default: yes)
    * Activating this might reduce the appearance of vertical ridges or seams on a printed shape.  Personally, I prefer to first reduce the size of ridge or seam produced.

### Craft > Lash ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Lash

  * Activate – No

### Craft > Limit ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Limit

  * Activate limit – Yes
  * Maximum initial feed rate (mm/s) - 30.0 (range: 30 - 75, default: 1.0!)

("Maximum Z feed rate (mm/s) - 3.0" is no longer displayed on this tab - documentation says it has been moved top "speed" tab.)

### Craft > Multiply ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Multiply

This is used purely to locate the print towards the centre of the print layer, on the assumption that STL file X, Y data is centred around the origin.

  * Activate multiply – Yes

-Centre-
  * Centre X (mm) - 100
  * Centre Y (mm) - 105

-Number of cells-
  * Number of columns (integer) - 1
  * Number of rows (integer) - 1

  * Reverse sequence every odd layer - (default: no)
  * Separation over perimeter width (ratio) - 15.0

### Craft > Oozebane ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Oozebane

  * Activate oozebane – No

### Craft > Preface (can’t be turned off) ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Preface

  * Set positioning to absolute – Yes
  * Set units to millimetres – Yes
  * Start at home - (default: No)
    * Note that the start.gcode file used includes homing instructions.

-Turn extruder off-
  * Turn extruder off at shut down - (default: Yes)
  * Turn extruder off at start up - (default: Yes)

### Craft > Raft ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Raft

Raft is used here with zero number of raft layers, to modify the feed rate used at different parts of the build.  Especially to print the first layer slowly so it sticks better to the base plate.

Note that Temperature settings have moved to Temperature tab. However Raft still has to be activated for temperature to work.

Also note, object first layer speed settings are moved to the Speed tab.

Lots of info at http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Raft

  * Activate raft – Yes
  * Add raft, elevate nozzle, orbit – Yes

-Base-
  * Base feed rate multiplier (ratio) 1.0
  * Base flow rate multiplier (ratio) 1.0
  * Base infill density (ratio) 0.5
  * Base layer thickness over layer thickness 2.0
  * Base layers (integer) 0
  * Base nozzle lift over base layer thickness (ratio) 0.5 (default: 0.4, range: 0.4 - 0.5)

  * Initial circling - (default: No)
  * Infill overhang over extrusion width (ratio) - (default: 0.05)

-Interface-
  * Interface feed rate multiplier (ratio) 1.0
  * Interface flow rate multiplier (ratio) 1.0
  * Interface infill density (ratio) 0.5
  * Interface layer thickness over layer thickness 1.0
  * Interface layers (integer) 0
  * Interface nozzle lift over interface layer thickness (ratio) 0.45

-Name of alteration files-
  * Name of support end file - (default: support\_end.gcode)
  * Name of support start file - (default: support\_start.gcode)

  * Operating nozzle lift over layer thickness (ratio) - 0.6 (default: 0.5, range: 0.2 - 0.6)
    * Was 0.5; this value moves nozzle close for 1st layer -- see http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Raft
    * Optimum value may vary with printer setup - see "bottom"

-Raft size-
  * Raft additional margin over length (%) - 1.0
  * Raft margin (mm) - 3.0

-Support-
  * Activate support cross hatch – (default: No)
  * Support Flow Rate over Operating Flow Rate - (default: 1.0)
  * Support Gap over Perimeter Extrusion Width - (default: 1.0)
  * Support Material Choice - (default - none)
  * Support Minimum Angle (degrees) - (default: 60)

### Craft > Scale ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Scale

Compensates for shrinkage.

  * Activate scale – No

### Craft > Skin ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Skin

This is a new tab, which invokes a process for printing a smoother skin.

**Activate skin - (default: No)**

### Craft > Skirt ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Skirt

  * Activate skirt – Yes
  * Convex – Yes
  * Gap over perimeter width (ratio) - 5.0 (range: 5.0 - 10.0)
  * Layers to (index) 1

I find this helps to get the print head extruding cleanly for the first object layer.

### Craft > Smooth ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Smooth

  * Activate Smooth - (default: No)

### Craft > Speed ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Speed

Some fields have been moved here from other panels.

I have found that I need to reduce some of the speeds to get decent print quality, or the extruded filament tends to drag along with the print head, especially when it changes direction sharply.  This also helps to reduce loops which can occur of the filament is not feeding smoothly into the extruder barrel.

  * Activate speed – Yes
  * Add flow rate – Yes

-Bridge-
  * Bridge feed rate multiplier (ratio) - 1.0
  * Bridge flow rate multiplier (ratio) - 1.0

-Duty cycle-
  * Duty cycle at beginning (portion) - 1.0
  * Duty cycle at ending (portion) - 0.0
  * Feed rate (mm/s) - 25.0 (default: 16.0, range: 15 - 40)
  * Flow rate setting (float) - 25.0 (default: 210, range: 15 - 40)
    * should be same as feed rate with 5D firmware

-Object first layer-
  * Object first layer feed rate infill multiplier (ratio) - 0.45 (default: 0.4, range: 0.3 - 0.6)
  * Object first layer feed rate perimeter multiplier (ratio) - 0.3 (default: 0.4, range: 0.2 - 0.5)
  * Object first layer flow rate infill multiplier (ratio) - 0.45 (default: 0.4, range: 0.3 - 0.6)
  * Object first layer flow rate perimeter multiplier (ratio) - 0.31 (default: 0.4, range: 0.22 - 0.6)
    * Set slightly higher than first layer feed rate to lay down extra plastic on base layer, in an attempt to reduce "dragging" of tracks and improve adhesion to print base.

  * Orbital feed rate over operating feed rate (ratio) - 0.5
  * Maximum Z feed rate (mm/s) - 3.0

-Perimeter-
  * Perimeter feed rate over operating feed rate (ratio) - 0.6 (default: 1.0, range: 0.3 - 1.0)
  * Perimeter flow rate over operating flow rate (ratio) - 0.6 (default: 1.0, range: 0.3 - 1.0)
  * Travel feed rate (mm/s) - 40.0 (default: 16.0, range: 25.0 - 50.0)

### Craft > Splodge ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Splodge

  * Activate splodge – No

### Craft > Stretch ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Stretch

"Stretch is very important Skeinforge plugin that allows you to partially compensate for the fact that extruded holes are smaller then they should be"

  * Activate stretch – Yes (default: No)
  * Cross limit distance over perimeter width (ratio) 5.0
  * Loop stretch over perimeter width (ratio) 0.11
  * Path stretch over perimeter width (ratio) 0.0

-Perimeter-
  * Perimeter inside stretch over perimeter width (ratio) 0.32
  * Perimeter outside stretch over perimeter width (ratio) 0.1
  * Stretch from distance over perimeter width (ratio) 2.0

### Craft > Temperature ###

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Temperature

  * Activate – No

(Note that documentation says that Raft has to be activated for temperature settings to work.)

Currently, I use an extruder temperature in the range 195 - 200 for printing PLA (as reported by my hardware). I have used values in the range 190 - 210C   (Currently, I use a single preset temperature set in RepSnapper, but in due course I'll experiment with letting Skeinforge control the temperature. My previous experience (with a RapMan printer) has been that the delays introduced to allow the print head to change temperature cause more problems (mainly oozing) than they solve.

### Craft > Tower ###

Extrude a disconnected region for a few layers.



See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Tower

  * Activate – No

### Craft > Unpause ###

Speed up a line segment to compensate for the delay of the microprocessor.

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Unpause

  * Activate – No

### Craft > Widen ###

Widen walls which are less than a double perimeter width wide.

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Widen

  * Activate – No

### Craft > Wipe ###

Define a wipe path.

See: http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge_Wipe

  * Activate – No


## Other Useful links ##

  * http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan - has some useful explanations of Skeinforge settings.
  * http://davedurant.wordpress.com/2010/11/01/skeinforge-movin-on-up-to-a-recent-version/ - more explanations, though incomplete and a bit dubious in places