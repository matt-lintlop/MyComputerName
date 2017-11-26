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

-(void)testEnumeration {
    
    NSArray *names = @[@"Bill", @"Bob", @"Mary", @"Chris", @"Roger", @"Cathy"];
    [names enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%ld %@", idx, obj);
    }];
}

- (NSArray*)mergeSortNumbers:(NSArray *)numbers {
    if (numbers.count <= 1) {
        return numbers;
    }
    
    int mid = (numbers.count-1) / 2;
    NSMutableArray *left = [NSMutableArray array];
    for (int i=0; i<=mid; i++) {
        [left addObject:numbers[i]];
    }
    NSMutableArray *right = [NSMutableArray array];
    for (int i=mid+1; i<numbers.count; i++) {
        [right addObject:numbers[i]];
    }
    left = [[self mergeSortNumbers:left] mutableCopy];
    right = [[self mergeSortNumbers:right] mutableCopy];
    return [self mergeList1:left withList2:right];
}
- (NSArray*)mergeSortNumbers:(NSArray *)numbers left:(int)left right:(int)right {
    if (left >= right) return numbers;
    
    int mid = (left + right) / 2;
    NSArray *leftNumbers = [self mergeSortNumbers:numbers left:0  right:mid];
    NSArray *rightNumbers = [self mergeSortNumbers:numbers left:mid+1  right:right];
    return [self mergeList1:leftNumbers withList2:rightNumbers];
}

-(NSArray*)mergeList1:(NSArray *)list1 withList2:(NSArray *)list2 {
    int count1 = (int)list1.count;
    int index1 = 0;
    int count2 = (int)list2.count;
    int index2 = 0;
    NSMutableArray *mergeList = [[NSMutableArray alloc] initWithCapacity:count1+count2];
    int mergeIndex = 0;

    while ((index1 < count1) && (index2 < count2)) {
        if (list1[index1] < list2[index2]) {
            mergeList[mergeIndex] = list1[index1];
            mergeIndex += 1;
            index1 += 1;
        }
        else {
            mergeList[mergeIndex] = list2[index2];
            mergeIndex += 1;
            index2 += 1;
        }
    }
    
    while (index1 < count1) {
        mergeList[mergeIndex] = list1[index1];
        mergeIndex += 1;
        index1 += 1;
    }
    
    while (index2 < count2) {
        mergeList[mergeIndex] = list2[index2];
        mergeIndex += 1;
        index2 += 1;
    }

    return mergeList;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        
        MyMath *math = [[MyMath alloc] init];
        NSArray* numbers = [math createwRandomNumbersWithCount:100 max:1000];

        NSLog(@"================================\n\n");
        NSLog(@"Random Numbers:");
        [math showNumbers:numbers];
        
        NSArray *sorted = [math mergeSortNumbers:numbers];

        NSLog(@"================================\n\n");
        NSLog(@"Sorted Numbers:");
        [math showNumbers:sorted];
  
    }
    
}

