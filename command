1.checking current link:

ll filename

2.checking libgomp.so.1:

find / -name "libgomp.so.1*"
##after all suspected libgomp.so.1 listed, examine if GOMP_4.0 exists
strings /***/*****/******/libgomp.so.1 | grep GOMP_4.0

3.soft link

ln -s /*****/from/libgomp.so.1 /*****/to/libgomp.so.1
