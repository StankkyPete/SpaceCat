//
//  HudNode.m
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/17/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import "HudNode.h"
#import "Utilities.h"

@implementation HudNode

+(instancetype)hudNodeAtPosition:(CGPoint)position inFrame:(CGRect)frame {
    HudNode *hud = [self node];
    hud.name = @"HUD";
    hud.position = position;
    hud.zPosition = 10;
    
    
    SKSpriteNode *catHead = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_cat_1"];
    catHead.position = CGPointMake(20, -10);
    [hud addChild:catHead];
    
    hud.lives = MaxLives;
    
    SKSpriteNode *lastLifeBar;
    
    for (int i = 0; i <hud.lives; i++) {
        SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_life_1"];
        lifeBar.name = [NSString stringWithFormat:@"Life%d",i+1];
        
        [hud addChild:lifeBar];
        
        if (lastLifeBar == nil) {
            lifeBar.position = CGPointMake(catHead.position.x + 30, catHead.position.y);
        } else {
            lifeBar.position = CGPointMake(lastLifeBar.position.x + 10, lastLifeBar.position.y);
        }
        lastLifeBar = lifeBar;
    }
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    scoreLabel.name = @"ScoreLabel";
    scoreLabel.fontSize = 24;
    scoreLabel.text = @"0";
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    scoreLabel.position = CGPointMake(frame.size.width-20, -10);
    [hud addChild:scoreLabel];
    
    return hud;
}



-(void)addPoints:(NSInteger)points {
    self.score += points;
    SKLabelNode *scorelabel = (SKLabelNode*)[self childNodeWithName:@"ScoreLabel"];
    scorelabel.text = [NSString stringWithFormat:@"%d",self.score];
    
    
}

-(BOOL)loseLife {
    if (self.lives > 0) {
        NSString *lifeNodeName = [NSString stringWithFormat:@"Life%d",self.lives];
        SKNode *lifeToRemove = [self childNodeWithName:lifeNodeName];
        [lifeToRemove removeFromParent];
        self.lives--;
    }
    return self.lives == 0;
}


@end
