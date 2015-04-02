This page is intended to collect notes about mechanical tuning of a RepRap Mendel.



# Squaring the frame #

It's much easier to do this **before** installing the X-axis.  Follow the instructions at http://reprap.org/wiki/Mendel_frame#Assembly.  A small spirit can help to ensure the base is level.

# Setting the end-stop positions #

@@TODO

NOTE: don't make the mistake I made:  when homing the axes after any significant disturbance to the setup (mechanical adjustments, transportation, etc.) use RepSnapper to manually nudge the axes to their end stops and ensure the detectors are properly aligned and working before actually using the Home commands.  This is especially important for the Z axis.

# Levelling the X-axis #

@@TODO

# Levelling the print bed #

Note: 4mm MDF is **too thin** for the print bed: it bends and the base layer doesn't go down cleanly.  I'm going to try with 6mm and see if that's better.  In the long run, I'll try for a sheet of glass on a heated bed, per http://reprap.org/wiki/Mendel_User_Manual:_Host_Software#Heated_beds.  6mm MDF also is too bendy - I'm now using 9mm MDF with satisfactory results.

@@TODO

Level X-axis first: see above.

Start with "clean" print head.

I use feeler guages 0.20mm and 0.25mm, or 0.25mm and 0.3mm, to measure height of print nozzle above each corner of the print table.

# Setting height of the print head #

Assume flag is roughly at correct length.

@@ TODO: use image of Z-endstop opto height adjustment; note interaction with Skeinforge settings

# Drive belt tension #

@@TODO:  Use image of uneven Wade extruder gear


# Extruder pinch-bearing tension #

The wade extruder pinch-bearing assembly doesn't ride up and down very smoothly on the long bolts that retain it, so it may need a lot of tension on the springs that push pinch bearing against the hobbed bolt.  I have found that tightening the nuts down until the spring coils are separated by a little under than the diameter of the spring wire seems to work.  (The springs themselves should be very stiff, ideally made from 1mm diameter wire, or something like that.)


# Print temperature #

I seem to have encountered some problems that I thought might be due to the extruder hot end being too cool, but which may in fact have been the opposite.

When laying down the "cross-hatch" infill, the filament sometimes does not seem to stick to the layer below, and "bobbles", creating an uneven surface, large gaps, and probably a weak object.  I thought this might be due to the temperature being too low, but it seems that this can happen when the extruder is running too hot:  the filament is more "liquid" and does not lay itself out so smoothly. This is most noticeable when the print head feed rate is higher.

Currently, I use an extruder temperature in the range 195-205C for printing PLA (as reported by my hardware).  (Currently, I use a single preset temperature set in RepSnapper, but in due course I'll experiment with letting Skeinforge control the temperature.  My previous experience (with a RapMan printer) has been that the delays introduced to allow the print head to change temperature cause more problems (mainly oozing) that they solve.


# Links #

@@TODO