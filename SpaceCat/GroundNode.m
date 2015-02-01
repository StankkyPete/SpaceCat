//
//  GroundNode.m
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/12/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import "GroundNode.h"
#import "Utilities.h"


@implementation GroundNode

+(instancetype) groundWithSize:(CGSize)size {
    GroundNode *ground = [GroundNode spriteNodeWithColor:[SKColor greenColor] size:size];
    ground.name = @"Ground";
    ground.position = CGPointMake(size.width/2, size.height/2);
    [ground setupPhysicsBody];
    
    return ground;
    
}


-(void)setupPhysicsBody {
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryGround;
    self.physicsBody.collisionBitMask = CollisionCategoryDebris;
    self.physicsBody.contactTestBitMask = CollisionCategoryEnemy;

}

@end
