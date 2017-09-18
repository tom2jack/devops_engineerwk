#!/usr/bin/env python
import sys as system
import math

num_list=[50,3,45,34,77,7653]
total, count = 0, 0
for num in num_list:
    total += num
    count += 1
else:
    print "Average list = %.2f" % (total / float(count))
