# Repair process

Below is my (informal) repair logbook.



#### 1. Power supply rails

   * all OK

     

#### 2. Clocks at D4 (8224)

   * `Φ1`, `Φ2`, `Φ2TTL` - all OK

     This is how `Φ1`, `Φ2` clocks look like (see the voltages? it's not TTL!) :

     ![](img/1_fi1_fi2.png)

   * `OSC` - 20MHz - OK
     
     At 20 MHz it doesn't look like square wave anymore ;)
     
     ![](img/2_osc.png)
     


   * `RESET` signal - OK



#### 3. STSTB - fault #1 

* I've checked `~MEMR`, `~MEMW`, etc. signals. It looked like the CPU is alive, but one signal looked invalid - `STSTB` (yellow trace):

  ![](img/5_ststb.png)

  * Most notably it exceeds 5V. Looking around I've found a short to Φ1 on the PCB. 

  * I guess it's the first time ever I **fix a problem with a toothbrush** :)

* with short removed, `STSTB` signal looked correctly:

![](img/3.1_ststb.png)

![](img/3.2_ststb_zoomed.png)



* believe it or not, the problem is inside the red circle :)

  ![](img/ststb_short.jpg)







#### 4. Timing block

* `D34` - in @ 20MHz OK, T3 at 1.25Mhz OK

* `mod 80` counting block

  * `T_RST1` is high for 16 cycles, i.e. `16 / 1.25MHz = 12.8μs`- OK

  * full cycle `1.25MHz / 80 = 15 625 Hz` - OK

  * below `A` (i.e. `T_RST1`) and `~Q` of `D43A`

    ![](img/4.1_d43a_a_nq.png)

  * below zoomed on  `~Q`output negative pulse:

    ![](img/4.2_d43a_a_nq_zoom.png)

    

* `mod 320` counter

  * full cycle: `15 625 / 320 = 48.82Hz` (this is vertical video sync frequency)

  * `T_RST2` - high for  64 cycles, i.e.  `64 / 15 625 = 4.096ms`

  * below: `A` and `~Q` of `D43B`:

    

    ![](img/4.3_d43b_a_nq.png)

    ![](img/4.4_d43b_a_nq_zoom.png)



#### 5. RAM controller - fault #2

* given that timing counters are working fine, there should be proper RAM cycles generated (`RAS`, `CAS`, address mux control signals, etc.)

  * nope..

* narrowed to a broken `D49` (`74138`) chip (3 bits to 1-of-8 decoder)

* after replacing `D49` it appeared to work, but I've decided to leave it as is and move on to other blocks, assuming I will get back to RAM later

  * spoiler: all was fine in this block

  
