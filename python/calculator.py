#!/usr/bin/env python
import math as m
import sys
import traceback

def sum (a, b):
    return a+b

def multiply(a, b):
    return a*b

def substract (a, b):
    return a-b

def divide (a, b):
    return float(a)/b

def mod(a, b):
    return a%b

def exp(a):
    return m.exp(a)

def sqrt(a):
    return m.sqrt(a)

def sin(a):
    return m.sin(a)

def cos(a):
    return m.cos(a)

def tan(a):
    return m.tan(a)

def getPi():
    return m.pi

def menu():
    print """
    1. sum
    2. multiply
    3. substract
    4. divide
    5. mod
    6. exp
    7. sqrt
    8. sin
    9. cos
    10. tan
    11. pi
    12. exit
    """
    choice = int(raw_input("Please give me a choice ? 1/2/3/4/5/6/7/8/9/10/11/12 "))
    return choice
choice, num1, num2 = None, None, None
while choice != 12:
    try:
        choice = menu()
        if choice == 1:
            num1 = input("Num 1 = ")
            num2 = input("Num 2 = ")
            print "{} + {} = {}".format(num1, num2, sum(num1,num2))
        elif choice == 2:
            num1 = input("Num 1 = ")
            num2 = input("Num 2 = ")
            print "{} * {} = {}".format(num1, num2, multiply(num1, num2))
        elif choice == 3:
            num1 = input("Num 1 = ")
            num2 = input("Num 2 = ")
            print "{} - {} = {}".format(num1, num2, substract(num1, num2))
        elif choice == 4:
            num1 = input("Num 1 = ")
            num2 = input("Num 2 = ")
            print "{} / {} = {}".format(num1, num2, divide(num1, num2))
        elif choice == 5:
            num1 = input("Num 1 = ")
            num2 = input("Num 2 = ")
            print "{} % {} = {}".format(num1, num2, mod(num1, num2))
        elif choice == 6:
            num1 = input("Num 1 = ")
            print "exp({}) = {}".format(num1, exp(num1))
        elif choice == 7:
            num1 = input("Num 1 = ")
            print "sqrt({}) = {}".format(num1, sqrt(num1))
        elif choice == 8:
            num1 = input("Num 1 = ")
            print "sin({}) = {}".format(num1, sin(num1))
        elif choice == 9:
            num1 = input("Num 1 = ")
            print "cos({}) = {}".format(num1, cos(num1))
        elif choice == 10:
            num1 = input("Num 1 = ")
            print "tan({}) = {}".format(num1, tan(num1))
        elif choice == 11:
            print "Pi = {}".format(getPi())
        elif choice == 12:
            print "Bye bye, see you again"
        else:
            print "Give me an number 1/2/3/4/5/6/7/8/9/10/11/12"
    except:
        print "Give me a valid number"
        traceback.print_exc()
