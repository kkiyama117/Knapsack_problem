# Template of makefile

# Write below after "TARGET =" the name of your program without ".c".
# (As the name of the sample program is "gap.c", the following
# line is "gap".)

TARGET = gap

# You can change the compiler, but note that the competition will
# be done by using "gcc -O2".

CC= gcc
CFLAGS= -Wall -O2

$(TARGET): $(TARGET).o
	$(CC) $(CFLAGS) -o $(TARGET) $(TARGET).o -lm

$(TARGET).o: $(TARGET).c cpu_time.c
	$(CC) $(CFLAGS) -c $(TARGET).c

gap:
gap_old:
gap_a:

run:
	cat data/c05100 | ./gap timelim 300

run2:
	cat data/d05200 | ./gap timelim 300

run_old:
	cat data/c05100 | ./gap_old timelim 300

check_old:
	cat data/c05100 data/sol_c05100-1931 | ./gap_old givesol 1
	cat data/c05100 data/sol_c05100-infeas | ./gap_old givesol 1

clean:
	rm *.o
