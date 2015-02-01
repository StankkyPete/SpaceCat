//
//  ProjectileNode.h
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/11/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ProjectileNode : SKSpriteNode

+(instancetype)projectileAtPosition:(CGPoint)position;
-(void)moveTowardsPosition:(CGPoint)position;

@end
