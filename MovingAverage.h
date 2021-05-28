#ifndef MOVINGAVERAGE_H
#define MOVINGAVERAGE_H

#include <queue>

class MovingAverage {
public:
    /** Initialize your data structure here. */
    double runningTotal;
    unsigned int windowSize;
    std::queue<int> buffer;
    
    MovingAverage(unsigned int inputSize);
    
    double next(int inputValue);
};


#endif //MOVINGAVERAGE_H