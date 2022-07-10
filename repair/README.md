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

  Most notably it exceeds 5V. Looking around I've found a short to Φ1 on the PCB. I guess it's the first time ever I **fix a problem with a toothbrush** :)

* with short removed, `STSTB` signal looked correctly:

![](img/3.1_ststb.png)

![](img/3.2_ststb_zoomed.png)



* believe it or not, the problem is inside the red circle :)

  ![](img/ststb_short.jpg)







#### 4. Timing block

* timing counters - all outputs OK
* 
