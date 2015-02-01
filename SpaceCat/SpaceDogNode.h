//
//  SpaceDogNode.h
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/12/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, SpaceDogType) {
    SpaceDogTypeA = 0,
    SpaceDogTypeB = 1
};

@interface SpaceDogNode : SKSpriteNode
@property (nonatomic, getter = isDamaged) BOOL damaged;
@property (nonatomic) SpaceDogType type;

+ (instancetype) spaceDogOfType:(SpaceDogType)type;


@end
