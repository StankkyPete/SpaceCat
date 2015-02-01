//
//  ProjectileNode.m
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/11/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import "ProjectileNode.h"
#import "Utilities.h"

@implementation ProjectileNode


+(instancetype)projectileAtPosition:(CGPoint)position {
    ProjectileNode *projectile = [self spriteNodeWithImageNamed:@"projectile_1"];
    projectile.position = position;
    projectile.name = @"Projectile";
    
    [projectile setupAnimation];
    
    [projectile setupPhysicsBody];
    
    return projectile;
}



-(void)setupAnimation {
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"projectile_1"],
                          [SKTexture textureWithImageNamed:@"projectile_2"],
                          [SKTexture textureWithImageNamed:@"projectile_3"]];
    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    SKAction *repeatAction = [SKAction repeatActionForever:animation];
    
    [self runAction:repeatAction];
}



-(void)moveTowardsPosition:(CGPoint)position {
    //slope = y3 - y1 / x3-x1
    float slope = (position.y - self.position.y) / (position.x - self.position.x);
    
    //slope = (y2-y1) / (x2-x1)
    //(y2-y1) = slope(x2-x1)
    //y2 = slope(x2-x1) + y1
    float offscreenX;
    if (position.x <= self.position.x) {
        offscreenX = -10;
    } else {
        offscreenX = self.parent.frame.size.width + 10;
    }
    
    float offscreenY = (slope * offscreenX) - (slope * self.position.x) + self.position.y;
    
    CGPoint pointOffScreen = CGPointMake(offscreenX, offscreenY);
    
    float distanceA = pointOffScreen.y   - self.position.y;
    float distanceB = pointOffScreen.x - self.position.x ;
    
    float distanceC = sqrtf(powf(distanceA, 2) + powf(distanceB, 2));
    
    //distance = speed / time
    //time = distance / speed
    float time = distanceC / ProjectileSpeed;
    float waitForDuration = time * 0.70;
    float fadeOutDuration = time - waitForDuration;
    
    SKAction *moveProjectile = [SKAction moveTo:pointOffScreen duration:time];
    [self runAction:moveProjectile];
    
    NSArray *sequences = @[[SKAction waitForDuration:waitForDuration],
                           [SKAction fadeOutWithDuration:fadeOutDuration],
                           [SKAction removeFromParent]];
    
    [self runAction:[SKAction sequence:sequences]];
    
}

-(void)setupPhysicsBody {
    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:(self.frame.size.width)];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryProjectile;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryEnemy;
}
@end
