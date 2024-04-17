#!/bin/bash
echo "building active";
#0 is integers, 1 is float, 2 is doubles
dtype=1
make clean
make DTYPE=$dtype
num=1
until [ $num -gt 7 ]; do
	time=1
    until [ $time -gt 3 ]; do
        bin/runnable_$dtype $time >out_$num
        time=$(($time+1))
    done
	num=$(($num+1))
done

