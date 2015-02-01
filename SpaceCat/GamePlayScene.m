//
//  GamePlayScene.m
//  SpaceCat
//
//  Created by Peter Dorsaneo on 1/11/15.
//  Copyright (c) 2015 Peter Dorsaneo. All rights reserved.
//

#import "GamePlayScene.h"
#import "MachineNode.h"
#import "SpaceCateNode.h"
#import "ProjectileNode.h"
#import "SpaceDogNode.h"
#import "Utilities.h"
#import "GroundNode.h"
#import <AVFoundation/AVFoundation.h>
#import "HudNode.h"
#import "ExplosionEmitterNode.h"
#import "GameOverNode.h"

@interface GamePlayScene ()
//declare private properties
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;

@property (nonatomic) SKAction *damageSFX;
@property (nonatomic) SKAction *laserSFX;
@property (nonatomic) SKAction *explodeSFX;

@property (nonatomic) AVAudioPlayer *backgroundMusic;
@property (nonatomic) AVAudioPlayer *gameOverMusic;

@property (nonatomic) BOOL *gameOver;
@property (nonatomic) BOOL *restart;
@property (nonatomic) BOOL *gameOverDisplayed;

@end


@implementation GamePlayScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.lastUpdateTimeInterval = 0;
        self.timeSinceEnemyAdded = 0;
        self.addEnemyTimeInterval = 1.5;
        self.totalGameTime = 0;
        self.minSpeed = SpaceDogMinSpeed;
        self.gameOver = NO;
        self.restart = NO;
        self.gameOverDisplayed = NO;
        
//         Setup your scene here 
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        background.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
        [self addChild:background];
        
        MachineNode *machine = [MachineNode
                                machineAtPosition:CGPointMake(CGRectGetMidX(self.frame), 12)];
        [self addChild:machine];
        
        SpaceCateNode *spaceCat = [SpaceCateNode spaceCatAtPosition:CGPointMake(machine.position.x, machine.position.y-2)];
        [self addChild:spaceCat];
        
        self.physicsWorld.gravity = CGVectorMake(0, -0.8);
        self.physicsWorld.contactDelegate = self;
        
        GroundNode *ground = [GroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
        [self addChild:ground];
        
        [self setupSounds];
        
        HudNode *hud = [HudNode hudNodeAtPosition:CGPointMake(0, self.frame.size.height-20) inFrame:self.frame];
        [self addChild:hud];
        
       

        
    } return self;
    
}

-(void)didMoveToView:(SKView *)view {
    [self.backgroundMusic play];
 
    
    
}

-(void)setupSounds {
    self.damageSFX = [SKAction playSoundFileNamed:@"Damage.caf" waitForCompletion:NO];
    self.laserSFX = [SKAction playSoundFileNamed:@"Laser.caf" waitForCompletion:NO];
    self.explodeSFX = [SKAction playSoundFileNamed:@"Explode.caf" waitForCompletion:NO];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Gameplay" withExtension:@"mp3"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.backgroundMusic.numberOfLoops = -1;
    self.backgroundMusic.enableRate = YES;
    [self.backgroundMusic prepareToPlay];
    
    NSURL *gameOverURL = [[NSBundle mainBundle] URLForResource:@"GameOver" withExtension:@"mp3"];
    self.gameOverMusic = [[AVAudioPlayer alloc]initWithContentsOfURL:gameOverURL error:nil];
    self.gameOverMusic.numberOfLoops= 1;
    self.gameOverMusic.enableRate = YES;
    [self.gameOverMusic prepareToPlay];

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.gameOver) {
        for (UITouch *touch in touches) {
            CGPoint position = [touch locationInNode:self];
            
            [self shootProjectileTowardsPosition:position];
            
        }

    } else if (self.restart) {
        
        for (SKNode *node in [self children]) {
            [node removeFromParent];
        }
        
        GamePlayScene *scene = [GamePlayScene
                                sceneWithSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
        [self.view presentScene:scene];
    }
    
    
}

-(void)performGameOver {
    GameOverNode *gameOver = [GameOverNode gameOverNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [self addChild:gameOver];
    
    self.restart = (BOOL*)YES;
    self.gameOverDisplayed = (BOOL*)YES;

    [gameOver performAnimation];
    
    [self.backgroundMusic stop];
    [self.gameOverMusic play];
}


-(void)shootProjectileTowardsPosition:(CGPoint)position {
    SpaceCateNode *spaceCat = (SpaceCateNode*)[self childNodeWithName:@"SpaceCat"];
    [spaceCat performTap];
    
    MachineNode *machine = (MachineNode*)[self childNodeWithName:@"Machine"];
    
    ProjectileNode *projectile = [ProjectileNode projectileAtPosition:CGPointMake(machine.position.x, machine.position.y + machine.frame.size.height - 15)];
    [self addChild:projectile];
    [projectile moveTowardsPosition:position];
    
    [self runAction:self.laserSFX];
}

- (void) addSpaceDog {
    NSUInteger randomSpaceDog = [Utilities randomWithMin:0 max:2];
    
    SpaceDogNode *spaceDog = [SpaceDogNode spaceDogOfType:randomSpaceDog];
    float dy = [Utilities randomWithMin:SpaceDogMinSpeed  max:SpaceDogMaxSpeed];
    spaceDog.physicsBody.velocity = CGVectorMake(0.0, dy);

    //setup position for spacedog node to spawn
    float x = [Utilities randomWithMin:spaceDog.size.width + 10 max:self.frame.size.width - spaceDog.size.width - 10];
    float y = self.frame.size.height + spaceDog.size.height;
    spaceDog.position = CGPointMake(x, y);
    
    [self addChild:spaceDog];
}

- (void) update:(NSTimeInterval)currentTime {
    if ( self.lastUpdateTimeInterval ) {
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    
    if ( self.timeSinceEnemyAdded > self.addEnemyTimeInterval && !self.gameOver) {
        [self addSpaceDog];
        self.timeSinceEnemyAdded = 0;
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    if ( self.totalGameTime > 80 /*seconds*/ ) {
        self.addEnemyTimeInterval = 0.50;
        self.minSpeed = -360;
        
    } else if ( self.totalGameTime > 30 /*seconds*/) {
        self.addEnemyTimeInterval = 0.75;
        self.minSpeed = -250;
    } else if ( self.totalGameTime > 20 /*seconds*/) {
        self.addEnemyTimeInterval = 1.00;
        self.minSpeed = -175;
    } else if ( self.totalGameTime > 10 /*seconds*/) {
        self.addEnemyTimeInterval = 1.25;
        self.minSpeed = -150;
    }
    
    if (self.gameOver && !self.gameOverDisplayed) {
        [self performGameOver];
    }
    
}



- (void) didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask ) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    
    if ( firstBody.categoryBitMask == CollisionCategoryEnemy &&
        secondBody.categoryBitMask == CollisionCategoryProjectile ) {
        NSLog(@"BAM!");
        
        SpaceDogNode *spaceDog = (SpaceDogNode *)firstBody.node;
        ProjectileNode *projectile = (ProjectileNode*)secondBody.node;
        
        if ([spaceDog isDamaged]) {
            [self runAction:self.explodeSFX];
        
            [spaceDog removeFromParent];
            [projectile removeFromParent];
            [self createDebrisAtPosition:contact.contactPoint];
            
            ExplosionEmitterNode *contactExplosion = [ExplosionEmitterNode spaceDogDestroyedByExplosionAtPosition:contact.contactPoint];
            [self addChild:contactExplosion];
            
            [self addPoints:ScorePerHit];

        }
        
    } else if ( firstBody.categoryBitMask == CollisionCategoryEnemy &&
               secondBody.categoryBitMask == CollisionCategoryGround ) {
        NSLog(@"Hit ground!");
        
        [self runAction:self.damageSFX];
        SpaceDogNode *spaceDog = (SpaceDogNode *)firstBody.node;
        [spaceDog removeFromParent];
        [self createDebrisAtPosition:contact.contactPoint];
        
        ExplosionEmitterNode *explosion = [ExplosionEmitterNode newExplosionAtPosition:contact.contactPoint];
        [self addChild:explosion];
        
        [self loseLife];

    }
    
}


-(void)addPoints:(NSInteger)points {
    HudNode *hud = (HudNode*)[self childNodeWithName:@"HUD" ];
    [hud addPoints:points];
}

-(void)loseLife {
    HudNode *hud = (HudNode*)[self childNodeWithName:@"HUD"];
    self.gameOver = [hud loseLife];
    
}

-(void)createDebrisAtPosition:(CGPoint)position {
    NSInteger numberOfPieces = [Utilities randomWithMin:5 max:20];
    
    
    for (int i = 0; i < numberOfPieces; i++) {
        NSInteger *randomPiece = (NSInteger*)[Utilities randomWithMin:1 max:4];
        NSString *imageName = [NSString stringWithFormat:@"debri_%ld",(long)randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        [self addChild:debris];
        
        debris.physicsBody = [ SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = CollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = CollisionCategoryGround | CollisionCategoryDebris;
        debris.name = @"Debris";

        debris.physicsBody.velocity = CGVectorMake([Utilities randomWithMin:-150 max:150], [Utilities randomWithMin:150 max:300]);
        
        [debris runAction:[SKAction waitForDuration:2.0]
               completion:^{[debris removeFromParent];
        }];
        
    }
    
    
    
}



@end

