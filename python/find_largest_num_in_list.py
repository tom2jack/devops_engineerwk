largest_num=None
the_list=[1,4,5,3,3,6,1,43,5,3,543,3,5,6,5,3,4,324556,42,2,1,99,4,5,6,8,4,5659]
for num in the_list:
    if largest_num is None or largest_num < num:
        largest_num = num
else:
    print "The largest num is %d" % largest_num
