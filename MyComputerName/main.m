//
//  main.m
//  MyComputerName
//
//  Created by Matthew Lintlop on 11/23/17.
//  Copyright © 2017 Matthew Lintlop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdio.h>




@interface MyMath : NSObject {
    
}

-(id)init;
-(NSArray*)createwRandomNumbersWithCount:(int)count max:(int)max;

// Sorting
- (NSArray *)quickSortNumbers:(NSArray *)numbers;
- (int) binarySearchWithNumbers:(NSArray *)numbers left:(int)left right:(int)right value:(int)value;

typedef int (^myAddBlockType)(int, int);

@property (nonatomic) myAddBlockType myBlock;

@end




@implementation MyMath {
    
}
    
- (id)init {
    if ((self = [super init]) != nil) {
    }
    return self;
}

-(NSArray*)createwRandomNumbersWithCount:(int)count max:(int)max {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        int randomNumber = arc4random_uniform(max+1);
        [array addObject:[NSNumber numberWithInteger:randomNumber]];
    }
    return array;
}

-(void)showNumbers:(NSArray*)numbers {
    NSUInteger count = numbers.count;
    NSUInteger index;
    for (index = 0; index<count; index++) {
        NSLog(@"%ld = %d", index, [numbers[index] intValue]);
    }
    
}

- (NSArray *)quickSortNumbers:(NSArray *)numbers {
    if (numbers.count <= 1) {
        return numbers;
    }
    
    NSMutableArray *lessThan = [NSMutableArray array];
    NSMutableArray *greaterThan = [NSMutableArray array];
    NSMutableArray *pivots = [NSMutableArray array];
    
    NSNumber *pivot = numbers[0];
    for (NSNumber *value in numbers) {
        if (value.integerValue < pivot.integerValue) {
            [lessThan addObject:value];
        }
        else if (value.integerValue > pivot.integerValue) {
            [greaterThan addObject:value];
        }
        else {
            [pivots addObject:value];
        }
    }
    
    NSMutableArray *result = [NSMutableArray arrayWithArray:[self quickSortNumbers:lessThan]];
    [result addObjectsFromArray:pivots];
    [result addObjectsFromArray:[self quickSortNumbers:greaterThan]];
    return result;
}

- (int) binarySearchWithNumbers:(NSArray *)numbers left:(int)left right:(int)right value:(int)value {
    if (left <= right) {
        int mid = left + ((right - left)/2);
        
        if ([numbers[mid] intValue] == value) {
            // found the number!
            return mid;
        }
        else if (value < [numbers[mid] intValue]) {
            // search left side
            return [self binarySearchWithNumbers:numbers left:left right:mid-1 value:value];
        }
        else {
            // search right side
            return [self binarySearchWithNumbers:numbers left:mid+1 right:right value:value];
        }
    }
    else {
        // the given # was not found
        return -1;
    }
}


@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        
        MyMath *math = [[MyMath alloc] init];
        NSArray *numbers = [math createwRandomNumbersWithCount:50 max:1000];
        NSLog(@"================================\n\n");
        NSLog(@"Random Numbers:");
        [math showNumbers:numbers];
        
        NSArray *sorted = [math quickSortNumbers:numbers];
        NSLog(@"================================\n\n");
        NSLog(@"Sorted Numbers:");
        [math showNumbers:sorted];
  
        NSNumber *randonInArray = sorted[sorted.count/2];

        int result = [math binarySearchWithNumbers:sorted left:0 right:sorted.count-1 value:randonInArray.intValue];
        
        NSLog(@"Binary Serach Index = %d for value = %d", result, randonInArray.intValue);
    }
    
}


