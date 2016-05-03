import math as m

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
            num1 = int(raw_input("Num 1 = "))
            num2 = int(raw_input("Num 2 = "))
            print "Result = %d" % sum(num1, num2)
        elif choice == 2:
            num1 = int(raw_input("Num 1 = "))
            num2 = int(raw_input("Num 2 = "))
            print "Result = %d" % multiply(num1, num2)
        elif choice == 3:
            num1 = int(raw_input("Num 1 = "))
            num2 = int(raw_input("Num 2 = "))
            print "Result = %d" % substract(num1, num2)
        elif choice == 4:
            num1 = int(raw_input("Num 1 = "))
            num2 = int(raw_input("Num 2 = "))
            print "Result = %.2f" % divide(num1, num2)
        elif choice == 5:
            num1 = int(raw_input("Num 1 = "))
            num2 = int(raw_input("Num 2 = "))
            print "Result = %d" % mod(num1, num2)
        elif choice == 6:
            num1 = int(raw_input("Num 1 = "))
            print "Result = %f" % exp(num1)
        elif choice == 7:
            num1 = int(raw_input("Num 1 = "))
            print "Result = %f" % sqrt(num1)
        elif choice == 8:
            num1 = int(raw_input("Num 1 = "))
            print "Result = %f" % sin(num1)
        elif choice == 9:
            num1 = int(raw_input("Num 1 = "))
            print "Result = %f" % cos(num1)
        elif choice == 10:
            num1 = int(raw_input("Num 1 = "))
            print "Result = %f" % tan(num1)
        elif choice == 11:
            print "Pi = %f" % getPi()
        elif choice == 12:
            print "Bye bye, see you again"
        else:
            print "Give me an number 1/2/3/4/5/6/7/8/9/10/11/12"
    except:
        print "Give me a valid number"
        


        



