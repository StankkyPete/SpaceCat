//
//  Utilities.h
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/12/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int ProjectileSpeed = 1000;
static const int XYScale = 2.0;
static const int SpaceDogMinSpeed = -100;
static const int SpaceDogMaxSpeed = -50;
static const int MaxLives = 9;
static const int ScorePerHit = 100;

typedef NS_OPTIONS(uint32_t, CollisionCategory) {
    CollisionCategoryEnemy          = 1 << 0,   //0000
    CollisionCategoryProjectile     = 1 << 1,   //0010
    CollisionCategoryDebris         = 1 << 2,   //0100
    CollisionCategoryGround         = 1 << 3    //1000
};



@interface Utilities : NSObject

+(NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max;

@end
