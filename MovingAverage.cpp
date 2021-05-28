#include <queue>
#include "MovingAverage.h"
// #include <iostream>

MovingAverage::MovingAverage(unsigned int inputSize) {
    /*initialize values*/
    runningTotal = 0.0;
    windowSize = inputSize;
}
    
double MovingAverage::next(int inputValue) {
    /*check if buffer is full*/
    if (buffer.size() == windowSize)
    {
        /*subtract front value from running total*/
        runningTotal -= buffer.front();
        /*delete value from front of std::queue*/
        buffer.pop();
    }
    /*add new value*/
    buffer.push(inputValue);
    /*update running total*/
    runningTotal += inputValue;
    /*calculate average*/
    // std::cout<<runningTotal<<"\n";
    return static_cast<double>(runningTotal / buffer.size());
}