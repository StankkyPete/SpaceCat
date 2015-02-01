//
//  SpaceCateNode.h
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/11/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SpaceCateNode : SKSpriteNode

+(instancetype)spaceCatAtPosition:(CGPoint)position;
-(void)performTap;
@end
