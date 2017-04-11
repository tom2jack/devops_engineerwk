import sys as system
from sys import argv

script, filename = argv
print "Your file name is %s" % filename
ask = None
txt = None
while ask != "y" and ask != "Y" and ask != "N" and ask != "n":
    ask = raw_input("Do you want open another file Y/N")
    if ask == "Y" or ask == "y":
        filename=raw_input("Enter new filename:")
    elif ask == "N" or ask == "n":
        print "Okay, I keep the old filename: %s" % filename
    else:
        print "I dont recognize it"
try:
    txt = open(filename, "a+")
except IOError:
    print "%s is not exists" % filename
    system.exit()
print "Content %s" % txt.read()
txt.close()

try:
    txt = open(filename, "a+")
except IOError:
    print "%s is not exists" % filename
    system.exit()
ask=None
while ask != "y" and ask != "Y" and ask != "N" and ask != "n":
    print "I will trunacte file, do you want me ?Y/N",
    ask = raw_input("?")
    if ask == "N" or ask =="n":
        print "Bye bye"
    elif ask == "Y" or ask == "y":
        txt.truncate()
    else:
        print "Answer me"    
print "Enter three lines:"
for i in range(0,3):
    line = raw_input("Line: ")
    txt.write(line)
    txt.write("\n")
print "Finally I close it"
txt.close()
