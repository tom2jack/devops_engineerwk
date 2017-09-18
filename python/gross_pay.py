#!/usr/bin/env python
import sys
import math
#Write a program to prompt the user for hours and
#rate per hour to compute gross pay.
#Enter Hours: 35
#Enter Rate: 2.75
#Pay: 96.25

def computepay (hours, rate):
    if hours > 40:
        print "Your gross pay: %.2f$" % (40 * rate + ((hours-40) * rate * 1.5))
    else:
        print "Your gross pay: %.2f$" % (hours * rate)

try:
    hours = eval(raw_input("Enter your hours: "))
    rate = eval(raw_input("Enter your rate ($): "))
except:
    print "Error, please enter a numeric input"
    sys.exit()

computepay(hours, rate)
