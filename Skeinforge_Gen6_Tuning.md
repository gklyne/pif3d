<font size='5'><b>Skeinforge parameters for use with Gen6 Electronics</b></font>



This page is intended for collecting notes for using Skeinforge to generate GCode files for RepRap using Mendel-parts Gen6 electronics and firmware.

Specifically, the system upon which these notes are based is a [RepRap Mendel (@@ref)](http://@@ref) with a [Wade extruder drive (@@ref)](http://@@ref), controlled by [Gen6 electronics (@@ref)](http://@@ref) and [firmware (@@ref)](http://@@ref) and driven by [RepSnapper (@@ref)](http://@@ref) software.  Parameter descriptions refer to Skeinforge version 41 for generating G-codes; support for 5D GCodes was introduced about version 40 of Skeinforge, and some of the settings are quite different from earlier versions.

In preparing these notes, I shall liberally copy text from other makers.  Where available I'll include the source, attribution, and note any licence restrictions.  Otherwise, all original text on this page is licensed CC-BY 3.0 ([Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/)).

## Background ##

There are many and increasing versions of RepRap mechanics, firmware, electronics and supporting software, all signs of a vibrant developer community.  The downside of all this is that developments outpace documentation, and there are many different combinations in the field that require different setup.

Many of the PIF3D builds to date have chosen to use the Mendel-parts Gen6 electronics and firmware, which provide a relatively easy-to-use one-board solution for getting a RepRap machine up and running.  The Gen6 electronics are based on a Sanguino (variant of Arduino) controller - where the main RepRap community seem to be using Arduino mega based systems (similar, but possibly slightly different in ways I don't understand)

It turns out the host software support for Gen6 is rather limited.  At the time of writing, the only software I have been able to use is [RepSnapper](https://github.com/timschmidt/repsnapper)  under Windows.  This should be able to run on Linux, but to date I experience difficulties with the synchronization of USB/serial communication with the controller electronics.  The main community RepRap host software just doesn't seem to communicate with the Gen6 electronics; I've no idea why.

[RepSnapper](https://github.com/timschmidt/repsnapper) includes simple GCode generation software, but while the generated GCode does work, it lacks many of the refinements supported by Skeinforge, and I find it creates very poor quality prints:  not good enough to make usable RepRap parts.  So, Skeinforge it is.

## 5D GCode firmware ##

The 5-D firmware, which is the basis for the Gen6 firmware, is so-called because rather than controlling extruder rates through separate comments, it adds a 5th "dimension" to each GCode command for extrude length.

## Skeinforge ##

When setting up Skeinforge (>=v40) + Gen6 electronics (or other5D firmware), these links might be helpful background:
  * http://reprap.org/pipermail/reprap-dev/2011-March.txt - a fairly general HOWTO
  * http://www.tinkerin.gs/2011/01/what-is-5d.html - useful intro to basic concepts
  * http://www.tinkerin.gs/2010/12/volumetric-5d.html - interesting discussion of what happens to the plastic when it's forced out throug the hot end.
  * http://www.tinkerin.gs/2011/01/volumetric-5d-testing-continues_22.html - comment  about PLA; inconclusive
  * http://www.tinkerin.gs/2011/02/tilted-cube-test-print_05.html - these guys are really digging into the details of what's happening to get the best possible  print quality.  Right now, I'd settle for something usable.

Skeinforge version 041 generates extrude length values that are way too small for the default Gen6 firmware setup.  Repeated hunting through Skeinforge settings has failed to locate any parameter to control the extrude rate.

(The main Skeinforge tab covering this is "Dimension", which is not exactly evocative.)

From about Skeinforge 040 onwards, the extrude rate (steps per mm) is set in the firmware, not in Skeinforge.  And for Skeinforge, the expected value for extrude rate is steps per mm of **feedstock**, not extruded output.  So the preferred approach is to modify and reload the firmware with newly calibrated values (which can also be done to fix stepper motor directions).  I tried to avoid re-loading firmware until I had a basic working platform, but in the end gave up on that approach.

There's some fairly extensive discussion of this issue here:
  * http://forums.reprap.org/read.php?154,75635
which includes some thoughts for fudging the parameters to get something working without re-flashing the firmware.

In theory, when the firmware is calibrated to the local machine (where the diameter of the hobbed extruder drive bolt is a per-machine variable), the rest of the parameters can be calculated based on the required print characteristics.

### Skeinforge manual ###

I finally found a fairly comprehensive and up-to-date Skeinforge manual, covering most or all of the settings in recent versions:
  * http://fabmetheus.crsndoo.com/wiki/index.php/Skeinforge

### Accelerating Skeinforge performance ###

Various instructions for running Skeinforge recmmend also using Psyco to accelerate performance of the underlying Python system that runs Skeinforge.  But Psyco wil not run on 64-bit systems.  There are instructions for using Pypy to achieve a similar effect here:
  * http://eclecti.cc/bytes/speeding-up-skeinforge-with-pypy

### Random Skeinforge links ###

Some varied but possibly useful discussion here:
  * http://fabmetheus.blogspot.com/2011/02/bitcoin.htm


## Updating Gen6 firmware ##

The latest Arduino software (022) is not compatible with the Sanguino  hardware add-on needed for working with the Gen6 controller.  Instead, use the  complete arduino-018-incl\_sanguino package that can be downloaded from mendelfactory.com (the new domain name for mendel-parts web site). (http://www.mendel-parts.com/downloads/arduino-0018/arduino-0018-incl_sanguino.zip)

There's a utility caled 'avrdude' which is a general purpose Atmel upload/download/setup utility.  I used this to make a copy of the original
firmware image before pushing new ones to the Gen6 controller.  Again, the latest version doesn't work with the Gen6 electronics.  But there's a version that does work in the arduino download package from mendelfactory.com (link above):  look within the package for `arduino-0018/hardware/tools/avr/bin/avrdude.exe`.

All the firmware setings you need to tweak are in a file called configuration.h in a separate download from mendelfactory.com.  There are multiple firmware downloads available that look very similar: I've been working with one called `20110107_GEN6-FW_Mendel_Parts_TCST2103.zip`, which is almost identical (apart from a README) to another one called `20101216_0070_Mendel_Parts_new_opto_TCST2103_shipped_from_17DEC2010.zip`.  Download link: http://www.mendel-parts.com/downloads/firmware/GEN6/20110107_GEN6-FW_Mendel_Parts_TCST2103.zip.

For calibrating the X and Y axes, and for checking the extrude rate setting, I used the following simple GCode file, which used 5D GCode to print a single square of filament, 100mm on a side, and also to experiment with an extrusion multiplier factor to obtain an estimate of GCode extrusion::feed distance values ratio to obtain an extrusion flow rate that matches the feed rate.

```
# Sample GCode: lay down 100mm filament square
# Extrusion muktiplier on sides of square: 0.04 (E4 on each 100mm side)
G21
G90
G92 X0 Y0 Z0 E0
T0
G28                   # home X, Y and Z
G92 E0                # reset extrude dist
M104 S210             # temp
G0 X125 Y0 Z5 F250    # over purge cutout
G1 F100               # feed rate
G1 X125 Y0 Z5 F250    # over purge cutout
G92 E0
G1 X135 Y0 E4 F250    # prime extruder (1)
G1 X115 Y0 E8 F250    # prime extruder (2)
G0 X20 Y0 Z0.25       # Home and height for 1st layer
G1 X20 Y0 Z0.25 F250  # Reset feed rate
G92 E0
G1 X0 Y0 E0.8         # Lead-in ...
G92 E0
G1 X20 Y20 E1.2       # Lead-in to 1st corner
G1 X20 Y120 E4
G92 E0
G1 X120 Y120 E4
G92 E0
G1 X120 Y20 E4
G92 E0
G1 X20 Y20 E4
G92 E0
G1 X0 Y0 Z2.5 E-2
G0 X125 Y0 Z5
```


## Calibrating extruder with Gen6 electronics ##

My method is loosely based on the one described by @araspitfire (Al Adrian) at http://forums.reprap.org/read.php?154,75635,76724#msg-76724.

Before starting this procedure, compile and load the current Gen6 firmware onto the Gen6 board, having first used `avrdude` to makle a backup copy of the original.The software needed for this is all in the arduino+sanguino developer software available for download from the Mendel-parts web site (see notes above).  The `avrdude` command line I used to backup the firmware was:
```
  avrdude -c avrisp -b 38400 -i 10 -p m644p -P com3 -F -U flash:r:20110522-factory_gen6.hex:i
```

With filament loaded into the extruder, I start by sticking a marker (e.g. small post-it note) on the filament where it enters the extruder drive block, then use RepSnapper to reverse the extruder for a (nominal) 100mm.  Using a caliper with depth-guage, I then measure the distance the post-it rises above the extruder block. This gives me an approximate indication of the extruder calibration error.  Using this, I estimated a nominal distance that would mlore closely approximate to 100mm - in my case, this was about 800 with the unmodified Gen6 firmware. The previous measurement was repeated, but this time using the new estimated figure for the distance to extrude.  This larger value allows a more accurate estimate of the calibration error.

The next step is to modify the firmware source code, where all modifications are applied.  I assume the arduino development software and firmware code have been downloaded from Mendel-parts.

Start the arduino IDE, and locate and open file `FiveD_GCode_Interpreter.pde` in the firmware source directory.  This and a number of other files are opened as tabs in the IDE.  Select file `configuration.h`: all changes will be made in this file.

Three values are needed:
  * e: the original value for `E0_STEPS_PER_MM` from `configuration.h`
  * r: the extrusion distance requested using RepSnapper
  * d: the actual measured distance the filament moved

From these, calculate a new value:
  * e' = e\*r/d

In my case, the value used is 600; for similar hardware, other values are likely to be similar, but different due to manufacturing differences in the hobbed bolt used in the extruder to drive the filament.

Update `configuration.h` with the new value of e' for `E0_STEPS_PER_MM`, and select the arduino IDE "verify" function to check and recompile the firmware.  Assuming no errors, use the Upload option to load the revised firmware to the controller board.  (Remember to close down the RepSnapper program (or disconnect the printer), select the appropriate serial port and board type (**Tools > Serial Port** as appropriate, and **Tools > Board** to Sanguino in the arduino IDE.)

Repeat the calibration.  If the extriude distance is not the same as the requested extrude distance, repeat the process.


## Calibrating the X, Y and Z axes ##

This can theoretically be done by calculation, but I found it easier to use the GCode for a 100mm square listed above, and a Vernier caliper to measure the discrepancy between requested and actual distances moved.  There are several sets of parameter definitions in `configuration.h` that control scaling for different RepRap mechanical setups. The parameters I edited were these:

```
  #ifdef GRUB_PULLEYS
  // define the XYZ parameters of Mendel - grub-screw pulleys
    
    //#define X_STEPS_PER_MM   40.000   // Edited 20100715 @ EJE 10.047 // Edited by CamielG @ 20101216 - 40.000
    #define X_STEPS_PER_MM   35.71   // Edited 20110522 by GK; previous figure3 * 100/112
    #define X_STEPS_PER_INCH (X_STEPS_PER_MM*INCHES_TO_MM) // *RO
    #define INVERT_X_DIR 0
    
    //#define Y_STEPS_PER_MM   40.000   // Edited 20100715 @ EJE 10.047 // Edited by CamielG @ 20101216 - 40.000
    #define Y_STEPS_PER_MM   35.71   // Edited 20110522 by GK; previous figure3 * 100/112
    #define Y_STEPS_PER_INCH (Y_STEPS_PER_MM*INCHES_TO_MM) // *RO
    #define INVERT_Y_DIR 1
    
    //#define Z_STEPS_PER_MM   3333.592  // 833.398
    #define Z_STEPS_PER_MM     2976 // Edited 20110522 by GK; previous figure3 * 100/112
    #define Z_STEPS_PER_INCH (Z_STEPS_PER_MM*INCHES_TO_MM) // *RO
    #define INVERT_Z_DIR 0
  #endif
```

## Skeinforge parameters ##

Now the fun begins!

The starting point for my Skeinforge tuning comes from a [forum posting](http://www.mendel-parts.com/new_forum/phpBB3/viewtopic.php?p=1472&sid=359ccfcb62cc60207e5b11a9b6701113#p1472) by gary67:

My plan is to start with details from that posting, and revise/edit it and augment it with explanations as my understanding grows.

Range values shown are given as a rough suggestion only, and indicate values that I have used with some success.

### Profile ###

  * Profile type – Extrusion
  * Profile selection – PLA (Note it is possible to create new profiles)
  * Version – 11.04.26 (I assume this is the Skeinforge version - mine is the same)

### Craft > Bottom ###

  * Activate Bottom – Yes
  * Additional height over layer thickness (ratio) - 0.5 (range 0.2-0.5)
    * This parameter increases the height of the print head over the base when printing the first layer.  I'm not sure how it affects subsequent layers.  My Z=0 height is probably on the high side, so I find setting a smaller value for this parameter gives a cleaner first layer (coupled with slower feed rate for the first layer: see Raft settings).
    * Instead of adjusting this, change setting of Operating Nozzle Lift over Layer Thickness in Raft.
    * Optimum value may vary with printer setup, esp. Z-axis zero height.  I make final adjustments by adjusting the Z-axis zero height mechanically using the sensor screw adjustment.
  * Altitude (mm) - 0.0
    * "Sets bottom of carving to defined altitude" - http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Bottom. Maybe it is this parameter that should be adjusted to compensate for the initial Z-offset?
  * SVG viewer - webbrowser

### Craft > Carve ###

  * Add layer template to SVG – Yes
  * Extra decimal places (float) 2.0
  * Import coarseness (ratio) 1.0

  * Infill in direction of bridge – Yes
  * Layer thickness (mm) 0.4

-Layers-
  * Layers from (index) 0
  * Layers to (index) 912345678

  * Mesh type correct mesh – Yes
  * Perimeter width over thickness (ratio) - 1.7 (range: 1.5 - 1.8, default: 1.8)
    * "how thick the perimeter wall will be in relation to the layer thickness. Default value of 1.8 for default thickness of 0.4 states that single filament perimeter wall will be 0.4x1.8=0.72mm thick. This is an important calibration value. You need to be sure that speed of the head and extrusion rate in combination produce walls that are layer thickness x perimeter width over thickness thick" -- http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Carve.
    * Suggests to me that a value closer to 1.5 might be better, as my skirt comes out 0.5x0.5, which is very close to 0.4x0.6.  It does seem to be working well, along with the other settings.
    * I later increased this value to 1.7 as the solid infill areas seemed to be "overpopulated", and later caliper measurements of single-filament tracks were 0.4\*0.7 or 0.4\*0.8.

### Craft > Chamber ###

  * Activate chamber – No

### Craft > Clip ###

Clips the ends of loops to prevent bumps from forming

  * Activate clip – Yes
  * Clip over perimeter width (ratio) - 0.15
    * "Defines the ratio of the amount each end of the loop is clipped over the perimeter width. The total gap will therefore be twice the clip. If the ratio is too high loops will have a gap, if the ratio is too low there will be a bulge at the loop ends." -- http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Clip
    * _Gary76_ was using 0.5, but I found this was leaving gaps in the loops.  The original default was 0.15.
  * Maximum connection distance over perimeter width (ratio) 10.0

### Craft > Comb ###

  * Activate - No

### Craft > Cool ###

  * Activate – Yes
  * Cool type: slow down
  * Minimum time per layer: 75s
    * I am considering a smaller value for this: 60s? 45s?

### Craft > Dimension ###

  * Activate dimension – Yes
  * Absolute extrusion distance – Yes
  * Extruder retraction speed (mm/s) - 30.0 (down from 50)

-Filament-
  * Filament diameter (mm) 2.9 (measured with dial caliper) (range: 2.8 - 3.0)
  * Filament packing density (ratio) 1.0
  * Retraction distance (mm) 2.0 (range: 1.0 - 3.0)
  * Restart extra distance (mm) -0.03 (range: -0.01 - -0.05)
    * _Gary76_ was using 0.5, but I found this left large gaps in the build (later: this may have been caused by separate extruder probems)
    * I tried 0, and that was much better, but did tend to leave a few splodges at the start of internal runs.  I tried -0.05, but at that setting, the initial perimeter track did not stick to the base plate (though apart from that the print was very good.
    * At -0.03, with a rebuilt extruder, print quality is OK  I am getting some splodges at start of runs: maybe need to try -0.04 or -0.05 again?

### Craft > Export ###

  * Activate export – Yes
  * Add export suffix – Yes
  * Gcode small – Yes

### Craft > Fill ###

  * Activate fill – Yes

-Diaphragm-
  * Diaphragm period (layers) - 100
  * Diaphragm thickness (layers) - 0

-Extra shells-
  * Extra shells on alternating solid layer (layers) - 2
    * "Extra Shells - Shell is the "outline" extrusion. You can set different number for these outlines on alternating layers" -- http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Fill
    * Default value - not sure of purpose, unless to create some extra bonding between shell and infill.
  * Extra shells on base (layers) - 1
    * Tried 2, per http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Fill, but this left very little surface infill on small piece.  1 is OK if it sticks well to the print base.
  * Extra shells on sparse layer (layers) - 1

-Grid-
  * Grid circle separation over perimeter width (ratio) - 0.2
  * Grid extra overlap (ratio) - 0.1
  * Grid junction separation band height (layers) - 10
  * Grid junction separation over octagon radios at end (ratio) - 0.0
  * Grid junction separation over octagon radios at middle (ratio) - 0.0

-Infill-
  * Infill begin rotation (degrees) - 45.0
  * Infill begin rotation repeat (layers) - 1
  * Infill odd layer extra rotation (degrees) - 90.0
  * Line – Yes
  * Infill perimeter overlap (ratio) - 0.2
    * "Defines how much overlap there is between the infill pattern and perimeter loops. 0 means that the infill barely touches the perimeter, 1 gives an overlap of one complete extrusion width. A value of slightly more then 0 is recommended for a good bonding of the two" -- http://wiki.bitsfrombytes.com/index.php/Skeinforge_Fill#Infill_Perimeter_Overlap_.28ratio.29
    * Try 0.1
  * Infill solidity - 0.2
  * Infill width over thickness (ratio) - 1.5
    * Seems to control the density at which infill is laid down.  E.g. see http://www.bitsfrombytes.com/forum/post/infill-width-over-thickness
  * Solid surface thickness (layers) - 3

### Craft > Fillet ###

  * Activate – No

### Craft > Home ###

  * Activate – No

### Craft > Hop ###

  * Activate – No

### Craft > Inset ###

  * Activate – No
  * Turn heater off at shutdown - Yes

### Craft > Jitter ###

  * Activate – No

### Craft > Lash ###

  * Activate – No

### Craft > Limit ###

  * Activate limit – Yes
  * Maximum initial feed rate (mm/s) - 30.0 (range: 30 - 75)
  * Maximum Z feed rate (mm/s) - 3.0

### Craft > Multiply ###

This is used purely to locate the print towards the centre of the print layer, on the assumption that STL file X, Y data is centred around the origin.

  * Activate multiply – Yes

-Centre-
  * Centre X (mm) - 100
  * Centre Y (mm) - 105

-Number of cells-
  * Number of columns (integer) - 1
  * Number of rows (integer) - 1
  * Separation over perimeter width (ratio) - 15.0

### Craft > Oozebane ###

  * Activate oozebane – No

### Craft > Preface (can’t be turned off) ###

-Name of alteration files-

  * Name of end file – end.gcode
  * Name of start file – start.gcode
  * Set positioning to absolute – Yes
  * Set units to millimetres – Yes

Start and end codes are kept in the Skeinforge `skeinforge_application/alterations` folder:

start.code - includes code to prime extruder head:
```
G28;                   Home X, Y and Z
G21;                   Metric
G90;                   Absolute positioning
G92 X0 Y0 Z0 E0;       Zero the extruded length axes
T0;                    Select extruder
M104 S210.0;           Set extrude temperature
G0 X125 Y0 Z5 F250;    Over purge cutout
G92 E0;                Zero extruded length
G1 F250;               Feed rate
G1 X125 Y0 Z5 F250;    Over purge cutout
G92 E0;                Zero extruded length
G1 X135 Y0 E4 F250;    Prime extruder (1)
G1 X115 Y0 E8 F250;    Prime extruder (2)
G92 E0;                Zero extruded length again
G0 X0 Y0 Z0;           Home
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

### Craft > Raft ###

Raft is used here with zero number of raft layers, to modify the feed rate used at different parts of the build.  Especially to print the first layer slowly so it sticks better to the base plate.

Lots of info at http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Raft

  * Activate raft – Yes
  * Add raft, elevate nozzle, orbit – Yes

-Base-
  * Base feed rate multiplier (ratio) 1.0
  * Base flow rate multiplier (ratio) 1.0
  * Base infill density (ratio) 0.5
  * Base layer thickness over layer thickness 2.0
  * Base layers (integer) 0
  * Base nozzle lift over base layer thickness (ratio) 0.5 (range: 0.4 - 0.5)

-Interface-
  * Interface feed rate multiplier (ratio) 1.0
  * Interface flow rate multiplier (ratio) 1.0
  * Interface infill density (ratio) 0.5
  * Interface layer thickness over layer thickness 1.0
  * Interface layers (integer) 0
  * Interface nozzle lift over interface layer thickness (ratio) 0.45

-Object first layer-
  * Object first layer feed rate infill multiplier (ratio) - 0.45 (range: 0.3 - 0.6)
  * Object first layer feed rate perimeter multiplier (ratio) - 0.3 (range: 0.2 - 0.5)
  * Object first layer flow rate infill multiplier (ratio) - 0.45 (range: 0.3 - 0.6)
  * Object first layer flow rate perimeter multiplier (ratio) - 0.31 (range: 0.22 - 0.6)
    * Set slightly higher than first layer feed rate to lay down extra plastic on base layer, in an attempt ton reduce "dragging" of tracks and improve adhesion to print base.
  * Operating nozzle lift over layer thickness (ratio) - 0.6 (range: 0.2 - 0.6)
    * Was 0.5; this value moves nozzle close for 1st layer -- see http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan#Raft
    * Optimum value may vary with printer setup - see "bottom"

-Raft size-
  * Raft additional margin over length (%) - 1.0
  * Raft margin (mm) - 3.0

-Support-
  * Activate support cross hatch – No

### Craft > Scale ###

  * Activate scale – No

### Craft > Skirt ###

  * Activate skirt – Yes
  * Convex – Yes
  * Gap over perimeter width (ratio) - 5.0 (range: 5.0 - 10.0)
  * Layers to (index) 1

_Gary67_ notes: Initially I wasn’t getting a decent extrusion on the first layer of my prints so I added a skirt 10mm out from the print to solve this issue.

I find this helps to get the print head extruding cleanly for the first layer.

### Craft > Speed ###

I have found that I need to reduce some of the speeds to get decent print quality, or the extruded filament tends to drag along with the print head, especially when it changes direction sharply.

  * Activate speed – Yes
  * Add flow rate – Yes

-Bridge-
  * Bridge feed rate multiplier (ratio) - 1.0
  * Bridge flow rate multiplier (ratio) - 1.0

-Duty cycle-
  * Duty cycle at beginning (portion) - 1.0
  * Duty cycle at ending (portion) - 0.0
  * Feed rate (mm/s) - 25.0 (range: 15 - 40)
  * Flow rate setting (float) - 25.0 (range: 15 - 40; same as feed rate with 5D firmware)
  * Orbital feed rate over operating feed rate (ratio) - 0.5

-Perimeter-
  * Perimeter feed rate over operating feed rate (ratio) - 0.6 (range: 0.3 - 1.0)
  * Perimeter flow rate over operating flow rate (ratio) - 0.6 (range: 0.3 - 1.0)
  * Travel feed rate (mm/s) - 40.0 (range: 25.0 - 50.0)

### Craft > Splodge ###

  * Activate splodge – No

### Craft > Stretch ###

_I've no idea yet what this does_

  * Activate stretch – Yes
  * Cross limit distance over perimeter width (ratio) 5.0
  * Loop stretch over perimeter width (ratio) 0.11
  * Path stretch over perimeter width (ratio) 0.0

-Perimeter-
  * Perimeter inside stretch over perimeter width (ratio) 0.32
  * Perimeter outside stretch over perimeter width (ratio) 0.1
  * Stretch from distance over perimeter width (ratio) 2.0

### Craft > Temperature ###

  * Activate – No

So far, I have been using RepSnapper to set the target temperature in the range 205-208C (as indicated by my hardware), and letting the onboard electronics maintain that.  Later, I'll consider letting Skeinforge vary the temperature between different phases of the print.

I seem to have encountered a problem that I thought might be due to the extruder hot end being too cool, but which may in fact have been the opposite:

When laying down the "cross-hatch" infill, the filament sometimes does not seem to stick to the layer below, and "bobbles", creating an uneven surface, gaps, and probably a weak object. I thought this might be due to the temperature being too low, but it seems that this can happen when the extruder is running too hot: the filament is more "liquid" and does not lay itself out so smoothly. This is most noticeable when the print head feed rate is higher.  '''Later: this was probably caused by problems with extruder rather than any of the above causes.'''

Currently, I use an extruder temperature in the range 195 - 200 for printing PLA (as reported by my hardware). I have used values in the range 190 - 210C   (Currently, I use a single preset temperature set in RepSnapper, but in due course I'll experiment with letting Skeinforge control the temperature. My previous experience (with a RapMan printer) has been that the delays introduced to allow the print head to change temperature cause more problems (mainly oozing) than they solve.

### Craft > Tower ###

  * Activate – No

### Craft > Unpause ###

  * Activate – No

### Craft > Widen ###

  * Activate – No

### Craft > Wipe ###

  * Activate – No

## Useful links ##

  * http://edutechwiki.unige.ch/en/Skeinforge_for_RapMan - has some useful explanations of Skeinforge settings.
  * http://davedurant.wordpress.com/2010/11/01/skeinforge-movin-on-up-to-a-recent-version/ - more explanations, though incomplete and a bit dubious in places