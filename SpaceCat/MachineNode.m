//
//  MachineNode.m
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/11/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import "MachineNode.h"
#import "Utilities.h"


@implementation MachineNode

+ (instancetype) machineAtPosition:(CGPoint)position {
    MachineNode *machine = [self spriteNodeWithImageNamed:@"machine_1"];
    machine.position = position;
    machine.name = @"Machine";
    machine.anchorPoint = CGPointMake(0.5, 0);
//    machine.xScale = XYScale;
//    machine.yScale = XYScale;
//
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"machine_1"],
                          [SKTexture textureWithImageNamed:@"machine_2"]];
    
    SKAction *machineAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    SKAction *machineRepeat = [SKAction repeatActionForever:machineAnimation];
    [machine runAction:machineRepeat];
    
    
    return machine;
}

@end
