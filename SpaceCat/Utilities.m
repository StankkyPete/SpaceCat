//
//  Utilities.m
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/12/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities


+(NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max {
    return arc4random() % (max - min) + min;
}


@end
