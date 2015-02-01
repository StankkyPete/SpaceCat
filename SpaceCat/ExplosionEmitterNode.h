//
//  ExplosionEmitterNode.h
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/18/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ExplosionEmitterNode : SKEmitterNode

+(instancetype)newExplosionAtPosition:(CGPoint)position;

+(instancetype)spaceDogDestroyedByExplosionAtPosition:(CGPoint)position;

@end
