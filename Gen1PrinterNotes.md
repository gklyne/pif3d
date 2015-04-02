# To Launch #

Step-by-step instructions:
  1. in Ubuntu download skeinforge (Python will need to have been installed)
  1. to start skeinforge go to the root of where you have downloaded it
    1. to list which directories use the 

&lt;ls&gt;

 command
    1. to change directories use the 

&lt;cd&gt;

 command, e.g. "cd RepRap" > 

&lt;ls&gt;

 > cd skeinforge > etc.
  1. Once you are in the root folder with the "skeinforge.py" file start skeinforge by starting python with the .py file: <python skeinforge.py>
  1. To open a STL file click on the "skeinforge" button in the bottom left hand side of the skeinforge GUI, this will open up a file browser.  It is easiest to just leave your STL files on your desktop so they are easy to find.
  1. Have the terminal widow open side by side to the skeinforge GUI as you can then watch as skeinforge runs through the STL file and transforms it into a GCODE file.
  1. Skeinforge will output the file (if it makes it through the render (watch the terminal window for errors) onto the same folder as the original STL file (hence why having it on the desktop is handy.
  1. You'll need to change the mime type of the .gcode file to a .bfb file as this is what the console recognises on the RepStrap machine.
  1. Once you've put the <.bfb> file onto the SD card you can then put it into the console of the RepMan printer.
  1. You can start the print job by selecting <run file> using the 'right arrow' button
  1. It will take 5 to ten minutes for the print head to get up to temperature, you should be able to see on the small lcd screen on the front of the repMan how hot the nozzle is getting including what temperature it is looking to achieve.

# Skeinforge settings #

Here are the settings for skeinforge that work with the printer named "_"_

Profile created on 2010-05-25
  * Profile Type: Extrusion
  * Profile selection PLA
  * Setting under the "craft" button:
    * 