//
//  TitleScene.m
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/10/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import "TitleScene.h"
#import "GamePlayScene.h"
#import <AVFoundation/AVFoundation.h>


@interface TitleScene ()
@property (nonatomic) SKAction *pressStartSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@end

@implementation TitleScene

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
    
    } return self;
}


-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    background.size = CGSizeMake(self.view.bounds.size.width*2, self.view.bounds.size.height*2);
    [self addChild:background];

    self.pressStartSFX = [SKAction playSoundFileNamed:@"PressStart.caf" waitForCompletion:NO];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"StartScreen" withExtension:@"mp3"];
    
    self.backgroundMusic = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    self.backgroundMusic.numberOfLoops= -1;
    [self.backgroundMusic prepareToPlay];
    [self.backgroundMusic play];

 }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    [self runAction:self.pressStartSFX];
    
    GamePlayScene *gamePlayScene = [GamePlayScene sceneWithSize:self.view.bounds.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:gamePlayScene transition:transition];
    
    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        
//        
//        //        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        //
//        //        sprite.xScale = 0.5;
//        //        sprite.yScale = 0.5;
//        //        sprite.position = location;
//        //
//        //        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        //
//        //        [sprite runAction:[SKAction repeatActionForever:action]];
//        //
//        //        [self addChild:sprite];
//        
//        
//        SKSpriteNode *greenNode = [[SKSpriteNode alloc]initWithColor:[UIColor greenColor] size:CGSizeMake(100, 100)];
//        
//        greenNode.xScale = 0.5;
//        greenNode.yScale = 0.5;
//        greenNode.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:0.5];
//        // SKAction *moveByAction = [SKAction moveBy:CGVectorMake(30.0, 30.0) duration:1];
//        
//        [greenNode runAction:[SKAction repeatActionForever:action]] ;
//        [self addChild:greenNode];
//    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
