//
//  GameOverNode.h
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/20/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameOverNode : SKNode

+(instancetype)gameOverNodeAtPosition:(CGPoint)position;

-(void)performAnimation;
@end
