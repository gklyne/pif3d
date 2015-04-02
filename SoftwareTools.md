(Moved from page about hardware supplies, and work-in-progress expanding covereage)



# 3D design and manipulation #

@@TODO
  * Blender
  * (Quick STL file viewer?)

## STL viewer ##

  * http://www.solidview.com/Products/SolidViewLite - a friend recoimmended this.  I haven't tried it, as it's Windows-only.

## Open source 3D CAD ##

http://www.openscad.org/

As well as the usual suspects (Blender, Art of Illusion) I just rediscovered a link to OpenSCad, which takes a different approach: http://www.openscad.org/.  There's a great demo/tutorial of OpenSCad at http://blog.onshoulders.org/BlogEntryDetails.php?blogID=tv&blogEntryId=95.

## MeshLab ##

  * http://meshlab.sourceforge.net/
  * http://meshlab.sourceforge.net/wiki/index.php/MeshLab_Documentation

I have found this useful for manipulating STL files (repositioning, removing objects, adding objects, etc.)

The user interface is a bit quirky, to put it mildly.  The only way I've found to duplicate parts in a mesh is to duplicate a layer, than apply transforms to the new layer, and finally to flatter the multiple layers back into a single layer. So, to create an STL mesh with an array of 4 objects.  This is the procedure that works for me, but I don't claim it's the best or only way:
  * start MeshLab
  * create a new project: File > New Empty Project
  * import the STL file with the required part: File > Import Mesh, select OK on the resulting dialog
  * show the "layer" summary: View > Show Layer Dialog; a new pane is displayed listing the original layer.  This may need to be repeated later, as the software seems to hode this pane when any other selection is made.
  * It may help to zoom out at this point: use scroll wheel or similar
  * Duplicate the current layer: Filters > Layer and Attribute Management > Duplicate Current Layer.  The display does not change, except for a new entry appearing in the layer pane.
    * Repeat the last command 2 more times, for a total of 4 layers listed, numbered 0 to 3
  * Select layer 1 in the layer pane; if the displayed pane is wide enough, a yellow flash is displayed to the right of the layer name.
  * Move the entire content of this layer to the right: Filters > Normals Curvature and Orientation > Transform: Move, Translate, Centre.  A dialog is displayed with values for X, Y and Z axes.  Enter an appropriate positive value into the X-axis box, ensure "Freeze Matrix" is selected (not sure if this is needed) then click on the Apply button.  You should now see two copies of the part.  Click the "Close" button.
  * Select layer 2 in the layer panel, and move its contents upwards, using the same procedure as before but entering an appropriate value into the Y axis field of the dialog.
  * Select layer 3 in the layer panel, and move its contents entering an appropriate values into both X- and Y axis fields.
  * At this point, four separate copies of the original object should be displayed.
  * Combine the 4 copies into a single layer: Filters > Layer and Attribute Management > Flatten Visible Layers.  The displayed parts don't visibly change, but the layer panel shows just one layer labelled "merged mesh"
  * Centre the resulting mesh: Filters > Normals Curvature and Orientation > Transform: Move, Translate, Centre, then select option "translate centre of the bbox to the" origin, click Apply then Close buttons.  (This step assumes that the Skeinforge parameters are chosen to move the object's origin to the centre of the platform for printing.)
  * Finally, write the resulting mesh to a new STL file:  File > Export Mesh As...   In the dialog box displayed, ensure STL File Format is selected for the output.

Another thing that I have MeshLab is useful for is deleting selected parts from a set of parts.  To do this, the STL file must be loaded into a new project, use one of the select tools (I prefer "select connected components in a region" to highlight the part(s) to be deleted.  The selection is cumulative if the CTRL/Command key is pressed.  The shift key negates parts of a selection.  To reset the selection, use Filters > Selection > Select None.  When the required part is selected,  use one of the delete buttons (also available via the Flters > Selection menu.

To build a mesh with multiple parts, use multiple File > Import Mesh, but take care to ensure the base layers are all at Z=0.  @@TODO: There's an option somewhere to align axes for different parts.

There is also some tutorial material for using MeshLab for setting up 3D print jobs at http://edutechwiki.unige.ch/en/Meshlab_for_RapMan_tutorial

## Art of Illusion ##

  * http://www.artofillusion.org/
  * http://reprap.org/wiki/AoI
  * STL import/export plugin, see: http://reprap.org/wiki/AoI#9._Hint:_Tidy_the_triangulation_before_writing_an_STL_file
> > In the latest versions of Art Of Illusion, you must install a plugin in order to enable Art Of Illusion to actually create STL files. You can do this from the "tools->Scripts & Plugins Manager->Install tab, or you can search for the STLTranslator jar file on the Art Of Illusion sourceforge page and copy it to your Art Of Illusion/Plugins directory.

To assemble several STL files into a single tray for printing:
  * Import each STL file into a separatee file (file > new, then import > stl).  Make sure the minimum precision value is set to a number >0 but less then the print precision of a RepRap; e.g. 0.01.
  * Copy and paste each STL file into a new common AoI workspace.  Move them so they are appropriately spread about in the X-Y plane.  I find it helpful to enabl;e the grid with 20mm divisions and 8 intermediate snap points per grid square.
  * With the X/Y layout setup, select all objects, then align all objects to be based at z=0;  Object > Align objects > Z-align back of object to 0.0
  * Save the resulting AoI and export to STL.

# GCode generation #

@@TODO:
  * RepRap host software

## `RepSnapper` ##

I tried RepSnapper GCode generation, but found it to be very poor.  I suggest Skeinforge for any serious printing.

## Skeinforge ##

Skeinforge is something of a swiss-army-knife GCode tool, and is the most commonly used tool for generating GCode for RepRap printing from STL files.  Skeinforge prerequisites include a Python compiler/interpreter.  It is a fairly complex program with many options that are not generally used for RepRap printing.

Skeinforge usage is covered in more detail in http://code.google.com/p/pif3d/wiki/Skeinforge_Gen6_Tuning

@@TODO link

# RepRap control desktop software #

I couln't get the Gen6 electronics/firmware to work with the RepRap (I think there are communication protocol incompatibilities), so I use RepSnapper.

@@TODO:
  * RepRap host software

## `RepSnapper` ##

@@TODO: provide link

I was unable to get `RepSnapper` running under Linux (though I believe others have managed this), so I'm currently running under Windows 7 (64-bit).  An FTDI vircual com port driver is required to talk to the electronics via the USB port (@@TODO: provide link and details of FTDI driver software install.  The FTDI driver may be standard on Windows).

Once the USB driver software is installed, power up the RepRap and connect to the host computer USB '''before''' running `RepSnapper`, or the USB COM port will not be visible for connection.  In `RepSnapper`, under the "Simple" menu tab, select the appropriate COM port (only one shows on my netbook), then use the GCode and Print tabs to perform detailed operations.

See: http://www.mendel-parts.com/new_forum/phpBB3/viewtopic.php?f=37&t=645

### Linux install notes (failed) ###

I tried running the standard RepRap host software on Ubuntu, but it would not drive the Gen6 electronics.  It seems that `RepSnapper` is preferred for Gen6 electronics.  But there is no binary install for `RepSnapper` (and the supporting `repraplib`) on Linux, so an install from source is needed.

One of the dependencies for building `RepSnapper` is `libusb-1.0`.  It took me a while to find the package that needs to be installed on Ubuntu for this.  Without it, the `RepSnapper` build claims to not support USB interfaces.
```
  sudo apt-get install libusb-1.0-0-dev
```

Having built `repraplib` and `RepSnapper`, per instructions, it's necessary to regenerate the dynamic library loader cache so that `RepSnapper` can find `repraplib` at run time:
```
  sudo ldconfig -v
```

It appears that there is a race condition in `RepSnapper`, or (more likely?) `repraplib`, when running on Linux.  Individual G-code commands are accepted and seem to work as expected, but multiple commands seem to force the host software out of sync with the RepRap machine, causing line number mismatch errors.  (The FiveD protocol starts each G-code command with `Nnnn`, where `nnn` is one greater that the number of the previous command sent.  This apparently allows for command retransmission.)

# RepRap firmware and development tools #

See also:
  * http://code.google.com/p/pif3d/wiki/Skeinforge_Gen6_Tuning
    * http://code.google.com/p/pif3d/wiki/Skeinforge_Gen6_Tuning#Updating_Gen6_firmware, etc

@@TODO
  * Arduino development toolchain
  * Sanguino add-on for Arduino toolchain
  * RepRap 5D firmware
  * Mendel-parts 5D firmware

# Other interesting stuff I stumbled upon #

  * http://www.opencsg.org/
    * http://www.nigels.com/research/
    * http://hackage.haskell.org/package/mecha, https://github.com/tomahawkins/mecha - an early-stage project to use Haskell for representing solid designs - I like the idea of designs as functional programs :)
    * See also: OpenSCAD above

# Other links #

  * http://reprap.org/
  * http://hydraraptor.blogspot.com/
  * http://objects.reprap.org/wiki/Parameterized_Mendel - links to parameterized (openSCAD) files for Mendel parts)