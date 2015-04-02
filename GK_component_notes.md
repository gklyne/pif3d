

# Introduction #

I've created this page as a dumping ground for bits of information I collect about possible RepRap component supplies and tools.  In due course, they should be integrated into the main pages.

# Components #

## Hot-end ##

  * http://richrap.blogspot.com/2010/10/making-new-extruder-nozzle-hot-end-diy.html
  * http://richrap.blogspot.com/2010/09/how-i-made-my-basic-extruder.html
  * http://www.slidesandballscrews.com/mounting-accesories-precision-round-rail-mounts-c-48_50.html

I'm particularly taken by the aluminium clamps he uses, and also hot-end designs
that use a block of metal with holes drilled for a power resistor and
thermistor (like mendel-parts', but this design is easier to make your own too).

Connecting the thermistior is a bit of a challenge: the leads are very fine and need insulation that survives at high temperatures.  Adrian suggests using insulation stripped from PTFE equipment hook-up wire.  I found such wire on ebay, e.g. http://stores.ebay.co.uk/M-A-Components/Cable-Wire-and-Heatshrink-, or search form PTFE wire.  For connections (too hot for solder), I purchsed bootlace ferrules from http://shop.ebay.co.uk/ghk1212/m.html - I haven't yet worked out what size I need, so I went for the assortment pack.

## Extruder drive ##

I've build the "Wade" extruder, which uses a "hobbed bolt" to drive the filament (see http://reprap.org/wiki/Wade%27s_Geared_Extruder).

I recently found a supplier on eBay who supplies M8 bolts with longer unthreaded shoulders in small quantitiutes, which are apparently easier to apply the hobbing.  The supplier is Spalding Fasteners (http://www.stores.ebay.co.uk/spalding-nut-and-bolt.  Bolt size M8x60mm has about 30mm shoulder.

## Electronics / controller ##

I'm considering using an off-the-shelf arduino mega as the basis of a controller.  I've seen the latest versions of these available for under £30 from China - e.g.

  * http://cgi.ebay.co.uk/Arduino-MEGA2560-ATMEGA2560-ATMEGA8U2-USB-Cable-/290543508404
  * http://shop.ebay.co.uk/ekitszone/m.html

Older versions with less memory are available for about half the price.

(This approach would mean that separate stepper controller and heater
controllers are needed.)

UPDATE: I'm going to use the Mendel-parts electronics for my first attempt, and use the Arduino initially for a heated bed controller.  Later, I hope to build a stock-arduino based controller.

## Power supplies ##

I've been trying to "size" a 12V power supply for a RepRap.  In particular, I've been trying to determine the power requirements for the extruder printer.

Mendel-parts says total of about 60W for their electronics, which I assume is all-in.

Along the way, I came across "NopHead"s blog, which is a veritable mine of information about RepRap and related matters: http://hydraraptor.blogspot.com/, but it takes some hubnting to dig it out.  On another blog (http://forums.reprap.org/read.php?70,40272,41556#msg-41556), he mentions using 20W extruder power at 50-80% duty cycle for 240C (which I think is for ABS), and links to this page: http://hydraraptor.blogspot.com/2007/09/equations-of-extrusion.html.

Stepper motors seem to peak at 2A (@12V?), but I'm guessing the average is much less.  Electronics should be trivial.  So 60W/5A @ 12V seems to be a reasonable figure.

The heated bed is a different matter altogether, and it appears that 100W at around 70% is needed (http://reprap.org/wiki/Mendel_heated_bed - this page also confirms to 60W figure for the main RepRap.

Hunting around for power supplies, it seems that ATX computer supplies are the easiest option for getting all this current.  Time to dismantle some old computers?

I did see one write-up for a "top-up" power supply for high performance graphics cards, with just 12V output at about 200W, installable into a 5.25" disk bay.

UDATE: in the end, I purchased a 400W "quiet" modular PC ATX power supply from Novatech for about £35.  This seems to be a better deal than any non PC power supply, and according to its spec can supply about 200W as 12V, plus 3.3V, 5V and -12V in case needed.  It also has a remote on/off.  Being a modular supply means that there are fewer uniused cables left flapping about.  I intend to connect it via a 24-way ATX extension lead with one end cut off and wired via a screw terminal block.


## Heated bed materials ##

See:
  * http://reprap.org/wiki/Heated_Bed
  * http://reprap.org/wiki/Mendel_heated_bed (this is my main source of guidance)

Materials:

  * DiBond (aluminium/HDPE sandwich):  I found a supplier of very cheap offcuts on eBay £4.50 for approx 8'x1' piece, but £8.50 carriage:  that's enough to make several heated beds!  If anyone else wants a piece, contact me (GK).
    * http://cgi.ebay.co.uk/ws/eBayISAPI.dll?ViewItem&item=290538592450
    * http://shop.ebay.co.uk/cornfield22/m.html
  * NiChrome wire: https://www.wires.co.uk/
    * https://www.wires.co.uk/acatalog/nc_bare.html (note wide range of resistivity available: I went for 10 and 30 ohms/metre)
  * Kapton Tape - eBay from China: http://shop.ebay.co.uk/shuvei/m.html
  * Bootlace Ferrules (for Nichrome, which cannot be soldered) from eBay:
    * http://cgi.ebay.co.uk/ws/eBayISAPI.dll?ViewItem&item=200466215855
    * http://shop.ebay.co.uk/ghk1212/m.html
  * Power MOSFET: VNP20N07 - this is in most respects a standard power MOSFET (20A/70V), but has in-built protection that should make it more robust in use.  There is also a 49A/40V version (VNP49N04) which should switch more power at 12V.
    * Good bet seems to be Farnell (http://uk.farnell.com/) or RS (http://uk.rs-online.com/)
      * http://uk.farnell.com/stmicroelectronics/vnp20n07-e/mosfet-omnifet-70v-20a-to-220/dp/1739425
      * http://uk.rs-online.com/web/6868515.html
    * Rapid also list it, but not as a standard stock item; they do stock the VPN49N04, at slightly higher price.
  * Thermistor: Epcos B57550G103J
    * RS online: http://uk.rs-online.com/web/4840149.html
  * Other electronic components
    * Capacitors: the 1000uF as Aluminium electrolytic offers required voltage (25V): check lifetime.
    * RS site is a nightmare here: lots listed, few in stock
  * Builder's crack-filling foam (Polyurathane foam)


# Connecting the stepper motors #

For normal stepper motor operations, the direction of the motor can be reversed by switching one pair of wires (1-2 or 3-4).  But using a microstepping controller doing this causes the motor to step forward and backwards rather than keep going in one direction.  In this case, to reverse the direction of the motor, swap **all** of the wires (1-2-3-4 -> 4-3-2-1).


# Driver software #

## `RepSnapper` ##

Tried running the standard RepRap host software on Ubuntu, but it would not drive the Gen6 electronics.  It seems that `RepSnapper` is preferred for Gen6 electronics.  But there is no binary install for `RepSnapper` (and the supporting `repraplib`) on Linux, so an install from source is needed.

One of the dependencies for building `RepSnapper` is `libusb-1.0`.  It took me a while to find the package that needs to be installed on Ubuntu for this.  Without it, the `RepSnapper` build claims to not support USB interfaces.
```
  sudo apt-get install libusb-1.0-0-dev
```

Having built `repraplib` and `RepSnapper`, per instructions, it's necessary to regenerate the dynamic library loader cache so that `RepSnapper` can find `repraplib` at run time:
```
  sudo ldconfig -v
```

It appears that there is a race condition in `RepSnapper`, or (more likely?) `repraplib`, when running on Linux.  Individual G-code commands are accepted and seem to work as expected, but multiple commands seem to force the host software out of sync with the RepRap machine, causing line number mismatch errors.  (The FiveD protocol starts each G-code command with `Nnnn`, where `nnn` is one greater that the number of the previous command sent.  This apparently allows for command retransmission.)

# Links #

  * http://reprap.org/
  * http://hydraraptor.blogspot.com/
  * http://objects.reprap.org/wiki/Parameterized_Mendel - links to parameterized (openSCAD) files for Mendel parts)