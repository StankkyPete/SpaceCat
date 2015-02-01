//
//  ExplosionEmitterNode.m
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/18/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import "ExplosionEmitterNode.h"

@implementation ExplosionEmitterNode

+(instancetype)newExplosionAtPosition:(CGPoint)position {
    
    ExplosionEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Explosions" ofType:@"sks"]];
    explosion.position = position;
//    explosion.numParticlesToEmit = 1000;
    explosion.zPosition = 3.0;
    
    [explosion  runAction:[SKAction waitForDuration:2.0] completion:^{
        [explosion removeFromParent];
    }];
    

    return explosion;
}


+(instancetype)spaceDogDestroyedByExplosionAtPosition:(CGPoint)position {
    ExplosionEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:
                                       [[NSBundle mainBundle]pathForResource:@"ContactExplosion" ofType:@"sks"]];
    explosion.position = position;
    explosion.zPosition = 3.0;
    
    [explosion runAction:[SKAction waitForDuration:2.0]completion:^{
        [explosion removeFromParent];
    }];
    
    return explosion;
}
@end
