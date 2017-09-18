#!/usr/bin/env python
try:
    print "What is your name ?"
    name = raw_input()
    age = int(raw_input("Your age? "))
    job = raw_input("What is your job ? ")
    print "Your name is %r, your age is %d and your job is %s" % (
name, age, job)
except:
    print "Catch the exception!"
