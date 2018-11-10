The [Field Kit by Koma Electronik](https://koma-elektronik.com/?product=field-kit) is an electronic musical instrument which includes a radio receiver, whose external antenna input is a 3-pin header socket.

This is **a 3D-printable case for an accessory which converts that socket to two BNC jacks.** Required additional components:

* 2 panel-mount BNC jacks, such as Amphenol 031-221-RFX.
* A length of 3-conductor ribbon cable and matching header pins and housing. These can be found sold as RC servo extension cables.
* Solder.
* Optional but recommended: about 25 mm of solid uninsulated wire.
* Glue and double-sided tape (see below).

This model is not particularly optimized; in particular, the case could use some strengthening ribs and the snap-fit does not hold very strongly. I glued mine shut after confirming it is working.

## Required parts and assembly

0. Print the box. You will almost certainly need to tweak the dimensions and iterate to suit your printer and wire. Test fit to ensure that:
     * The cable can fit through the opening for it.
     * The “panel” snaps into the “shell” firmly enough and the tab engages.
     * The cable is held in position, but not so tightly that the shell is excessively bent by the pressure.
1. Push the cable into the hole on the panel. (If your cable is multicolored, consider which way around you want it.)
2. Bend the BNC connectors' shield connection tags up so that they fit within the box and can be soldered without melting the plastic.
3. Secure the BNC connectors with their nuts.
4. Solder the connections.
   * The wire which will go to the Field Kit's GND should be joined to the shield of both BNC jacks; a length of solid wire may make a convenient bus bar for this.
   * The other two wires should go to the centers of the two BNC jacks; if you ensure the wires do not cross over each other then when in use they will be in the same order as the Field Kit's connection labels.
5. Close the box and test it.
6. Optional: Glue it shut with superglue unless you edited the model to improve the snap-fit.
7. Optional: Stick it to the side of your Field Kit with a 3M Command adhesive strip. Add a rubber foot to support it against the insertion force of the BNC plug without scraping the table.

## License

Copyright 2018 Kevin Reid <kpreid@switchb.org>.

This work is licensed under a <a rel="license" href="https://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 International License</a>.
