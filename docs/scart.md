# Connecting to TV via SCART

It is possible to connect video output to SCART TV input, however some modifications are necessary:

* 12V rail should be connected via 330R resistor to unused pin 1 of the `X5` video output socket.
  Used to drive:

    * SCART Slow Blank (pin 8) to force the TV to switch to SCART with 4:3 aspect ratio
  
    * SCART Fast Blank (pin 16) to force the TV to switch to RGB signals (as opposed to CVBS default)
  
      
  
* `R`,`G` and `B` signals have to be inverted (it seems there was a different standard in the Soviet Union). This can be done by soldering `7402` quad NOR chip on top of `D62` chip (`К155ЛЛ1`/`7432`, quad 2-input OR gate) as follows.
  
  * solder pins 3, 6, 7, 8 and 14 of the `7402` chip to same numbered pins of `D62`
  * bend pins 2, 5 and 9 and solder to pins 3, 6 and 8, respectively 
  * bend pins 1, 4, 10, 11, 12 and 13 up
  * remove `C53`, `C54` and `C55` output capacitors
  * connect pins 1, 4 and 10 to "minus" pads of `C54`,  `C53` and `C55`, respectively

## Cable

Once the mod is in place, use the following cable:

| DIN-7 | SCART       | Signal                                                         |
| ----- | ----------- | -------------------------------------------------------------- |
| 1     | 8           | Slow Blank                                                     |
| -     | 16          | Fast Blank, connect to pin 8 via 330R resistor inside the plug |
| 2     | 20          | CVBS / Sync In                                                 |
| 3     | 7           | Blue                                                           |
| 4     | 11          | Green                                                          |
| 5     | 15          | Red                                                            |
| 6     | 4, 5, 9, 13 | GND                                                            |

