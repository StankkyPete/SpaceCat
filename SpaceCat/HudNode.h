//
//  HudNode.h
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/17/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HudNode : SKNode
@property (nonatomic) NSInteger lives;
@property(nonatomic)NSInteger score;

+(instancetype)hudNodeAtPosition:(CGPoint)position inFrame:(CGRect)frame ;

-(void)addPoints:(NSInteger)points;

-(BOOL)loseLife;
@end
