# Connecting to TV via SCART

It is possible to connect vide output to SCART, however some modifications are necessary:

* 12V rail should be connected via 330R resistor to any unused pin (let's assume pin 1) of the `X5` video output socket.
  Used to drive:

    * SCART Slow Blank (pin 8) to force the TV to switch to SCART with 4:3 aspect ratio
  
    * SCART Fast Blank (pin 16) to force the TV to switch to RGB signals (as opposed to CVBS default)
  
      
  
* `R`,`G` and `B` signals have to be inverted (it seems there was a different standard in USSR). This can be done by replacing `D62` chip `К155ЛЛ1`/`7432` (quad 2-input OR gate) with `7402` NOR variant.
  
  * this can be done by soldering new chip on top of the old one with output pins bent up, but I prefer to replace original chip with a DIL-14 socket.

## Cable

Once the mods are in place, we can use the following cable:

| DIN-7 | SCART       | Signal                                                         |
| ----- | ----------- | -------------------------------------------------------------- |
| 1     | 8           | Slow Blank                                                     |
| -     | 16          | Fast Blank, connect to pin 8 via 330R resistor inside the plug |
| 2     | 20          | CVBS / Sync In                                                 |
| 3     | 7           | Blue                                                           |
| 4     | 11          | Green                                                          |
| 5     | 15          | Red                                                            |
| 6     | 4, 5, 9, 13 | GND                                                            |

Note:

* original recipe assumes removal (shorting) of `C53`, `C54` and `C55` output capacitors, but I don't think it is necessary.

