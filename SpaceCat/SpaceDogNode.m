//
//  SpaceDogNode.m
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/12/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import "SpaceDogNode.h"
#import "Utilities.h"


@implementation SpaceDogNode

+ (instancetype) spaceDogOfType:(SpaceDogType)type {
    
    SpaceDogNode *spaceDog;
    spaceDog.damaged = NO;
    
    NSArray *textures;
    
    if (type == SpaceDogTypeA) {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_A_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_A_2"]];
        spaceDog.type = SpaceDogTypeA;
    } else {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_B_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_2"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_3"]];
        spaceDog.type = SpaceDogTypeB;
    }
    
    float scale = [Utilities randomWithMin:50 max:100] / 100.0f;
    spaceDog.xScale = scale;
    spaceDog.yScale = scale;

    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    [spaceDog runAction:[SKAction repeatActionForever:animation]];
    
    [spaceDog setupPhysicsBody];
    
    return spaceDog;
}

-(void)setupPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.categoryBitMask = CollisionCategoryEnemy;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryProjectile | CollisionCategoryGround; //0010 | 1000 = 1010
}

-(BOOL)isDamaged {
    if (!_damaged) {
        [self removeActionForKey:@"animation"];
        NSArray *textures;
        if (self.type == SpaceDogTypeA) {
            textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_3"]];
        } else {
            textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_4"]];
        }
        
        SKAction *animation =[SKAction animateWithTextures:textures timePerFrame:0.1];
        [self runAction:[SKAction repeatActionForever:animation]withKey:@"damage_animation"];
        
        _damaged = YES;
        
        return NO;
    }
    return _damaged;
}
@end
