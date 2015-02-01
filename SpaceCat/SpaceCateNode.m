//
//  SpaceCateNode.m
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/11/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import "SpaceCateNode.h"
#import "Utilities.h"


@interface SpaceCateNode ()
@property (nonatomic) SKAction *tapAction;
@end

@implementation SpaceCateNode

+(instancetype)spaceCatAtPosition:(CGPoint)position {
    SpaceCateNode *spaceCat = [self spriteNodeWithImageNamed:@"spacecat_1"];
    spaceCat.position = position;
    spaceCat.anchorPoint = CGPointMake(0.5, 0.0);
    spaceCat.name = @"SpaceCat";
//    spaceCat.xScale = XYScale;
//    spaceCat.yScale = XYScale;
    
    
    return spaceCat;
}

-(void)performTap {
    [self runAction:self.tapAction];
}

-(SKAction *)tapAction {
    if (_tapAction != nil) {
        return _tapAction;
    }
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"spacecat_2"],
                          [SKTexture textureWithImageNamed:@"spacecat_1"]];
    _tapAction = [SKAction animateWithTextures:textures timePerFrame:0.25];
    
    return _tapAction;
}
@end
