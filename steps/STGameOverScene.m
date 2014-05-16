//
//  STGameOverScene.m
//  steps
//
//  Created by Tevy CHANH on 12/05/14.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "STGameOverScene.h"
#import "STGameStartScene.h"
#import "STMyScene.h"

@implementation STGameOverScene
{
    GameMode mode;
}

- (id)initWithSize:(CGSize)size mode:(GameMode)level score:(NSUInteger)player_score
{
    
    if(self = [super initWithSize:size])
    {
        [self displayBackground];
        
        mode = level;
        SKSpriteNode * startGameText = [SKSpriteNode spriteNodeWithImageNamed:@"game-over"];
        startGameText.position = CGPointMake(size.width * 0.45f, size.height * 0.8f);
        [self addChild:startGameText];
        
       SKLabelNode * playerscore = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        playerscore.text = [NSString stringWithFormat:@"%ld",(long)player_score];
        playerscore.fontColor = [SKColor whiteColor];
        playerscore.position = CGPointMake(self.size.width * 0.51f, size.height * 0.55f);
        [self addChild:playerscore];
        
       SKSpriteNode * retryButton = [SKSpriteNode spriteNodeWithImageNamed:@"btn-retry"];
        retryButton.name = @"retry";
        [retryButton setScale:0.6];
        retryButton.position = CGPointMake(size.width * 0.51f, size.height * 0.4f);
        [self addChild:retryButton];
        
       SKSpriteNode * menuButton = [SKSpriteNode spriteNodeWithImageNamed:@"btn-menu"];
        menuButton.name = @"menu";
        [menuButton setScale:0.6];
        menuButton.position = CGPointMake(size.width * 0.51f, size.height * 0.2f);
        [self addChild:menuButton];
        
    }
    return self;
}


- (void) displayBackground
{
    SKSpriteNode *background = [[SKSpriteNode alloc] initWithImageNamed:@"bg2"];
    background.zPosition = -1;
    background.position = CGPointMake(0, 0);
    background.size = self.frame.size;
    background.anchorPoint = CGPointMake(0, 0);
    [self addChild:background];
}


 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    SKScene *scene = ([node.name isEqualToString:@"retry"]) ? [[STMyScene alloc] initWithSize:self.view.bounds.size mode:mode]
    : ([node.name isEqualToString:@"menu"]) ? [STGameStartScene sceneWithSize:self.view.bounds.size] : nil;
    
    if (scene != nil)
    {
        SKTransition *reveal = [SKTransition fadeWithColor:[UIColor grayColor] duration:0.5];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: reveal];
    }
    
}

@end
