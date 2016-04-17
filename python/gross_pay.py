#Write a program to prompt the user for hours and
#rate per hour to compute gross pay.
#Enter Hours: 35
#Enter Rate: 2.75
#Pay: 96.25

hours = eval(raw_input("Enter your hours: "))
rate = eval(raw_input("Enter your rate ($): "))
print "Your gross pay: %.2f$" % (hours * rate)
