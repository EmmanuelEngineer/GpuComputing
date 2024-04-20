#!/bin/bash
echo "building active";
#0 is integers, 1 is float, 2 is doubles
optimizer=0

up_to=10
num_iterations=3
opt_num=0
time_num=0

until [ $opt_num -gt 3 ]; do
    dtype=0
    until [ $dtype -gt 2 ]; do
        make clean
        make DTYPE=$dtype OPT_NUM=$opt_num
        num=1
        until [ $num -gt $up_to ]; do
            time=1
            until [ $time -gt $num_iterations ]; do
                #valgrind --tool=cachegrind --cache-sim=yes bin/runnable_$dtype $num >out_$num\_$time
                bin/runnable_$dtype $num >Homework_runs/out_$num\_$time\_$dtype\_$opt_num\.txt
            time=$(($time+1))
            done
        num=$(($num+1))
        done
    dtype=$(($dtype+1))
    done
    opt_num=$(($opt_num+1))
done

