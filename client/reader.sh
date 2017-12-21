#!/bin/bash
######################################################################
# rtl_fm   : does rtl fm'ish things
# -d 0101  : device address - omit this if only one dongle
# -E dc    : removes DC spike
# -F 0     : does something to do with magic or something
# -l 15    : squelch setting, tune accordingly
# -A fast  : more magic
# -f 148.. : your frequency
# -s22050  : sample rate - this is the only valid option for multimon
######################################################################
# multimon-ng  : does multimoning
# -q		   : ssshhhh
# -b1		   : blocks a lot of false decodes, set to b0 if you still get some
# -c 		   : I forget what this does
# -a POCSAG512 : set to the protocol you're decoding
# -f alpha 	   : omit if you want non-alphanumeric pages
# -t raw 	   : tells multimon that you're coming from rtl_fm's pipe
# ./ch0.out   : the place where all the studs come from
######################################################################
# node reader.js : the cool thing that makes magic happen
######################################################################
#rtl_fm -d 0101 -E dc -F 0 -l 15 -A fast -f 148.5875M -s22050 - | 
#multimon-ng -q -b1 -c -a POCSAG512 -f alpha -t raw ./ch0.out | 
#node reader.js
cd /root/pagermon/client
mkfifo ./ch0.out ./ch1.out ./ch2.out ./ch3.out ./ch4.out ./ch5.out
multifm test.json pocsag_narrow.json &


multimon-ng  -t raw -q  -p -a POCSAG1200 -a POCSAG512  -a POCSAG2400 -f alpha ./ch0.out | node reader.js 148938000 &
multimon-ng  -t raw -q  -p -a POCSAG1200 -a POCSAG512  -a POCSAG2400 -f alpha ./ch1.out | node reader.js 148688000&
multimon-ng  -t raw -q  -p -a POCSAG1200 -a POCSAG512  -a POCSAG2400 -f alpha ./ch2.out | node reader.js 148637000&
multimon-ng  -t raw -q  -p -a POCSAG1200 -a POCSAG512  -a POCSAG2400 -f alpha ./ch3.out | node reader.js 148363000&
multimon-ng  -t raw -q  -p -a POCSAG1200 -a POCSAG512  -a POCSAG2400 -f alpha ./ch4.out | node reader.js 148414000&
multimon-ng  -t raw -q  -p  -a POCSAG1200 -a POCSAG512  -a POCSAG2400 -f alpha ./ch5.out | node reader.js 148562000&

wait
