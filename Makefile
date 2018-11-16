main: main.adb
	gnatmake -d -B -pg -O2 -fstack-check -gnata -gnatE -gnateV -gnatf -gnateF -gnaty -gnatv -gnatwa main

clean:
	gnatclean main

.PHONY: clean
