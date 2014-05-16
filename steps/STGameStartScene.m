//
//  STGameStartScene.m
//  steps
//
//  Created by Tevy CHANH on 12/05/14.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "STGameStartScene.h"
#import "STMyScene.h"

@implementation STGameStartScene

- (id)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        [self displayBackground];
        
        SKSpriteNode* gameTitle = [SKSpriteNode spriteNodeWithImageNamed:@"logo"];
        gameTitle.position = CGPointMake(size.width * 0.5f, size.height * 0.8f);
        [self addChild:gameTitle];
        
        SKSpriteNode* easyButton = [SKSpriteNode spriteNodeWithImageNamed:@"btn-easy"];
        easyButton.name = @"easy";
        [easyButton setScale:0.6];
        easyButton.position = CGPointMake(size.width * 0.51f, size.height * 0.5f);
        [self addChild:easyButton];

        SKSpriteNode* normalButton = [SKSpriteNode spriteNodeWithImageNamed:@"btn-normal"];
        normalButton.name = @"normal";
        [normalButton setScale:0.6];
        normalButton.position = CGPointMake(size.width * 0.51f, size.height * 0.3f);
        [self addChild:normalButton];

        SKSpriteNode* hardButton = [SKSpriteNode spriteNodeWithImageNamed:@"btn-hard"];
        hardButton.name = @"hard";
        [hardButton setScale:0.6];
        hardButton.position = CGPointMake(size.width * 0.51f, size.height * 0.1f);
        [self addChild:hardButton];
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
    
    GameMode mode = ([node.name isEqualToString:@"easy"]) ? EASY : ([node.name isEqualToString:@"normal"]) ? NORMAL : ([node.name isEqualToString:@"hard"]) ? HARD : NONE;
    
    if (mode != NONE)
    {
        SKTransition *reveal = [SKTransition fadeWithColor:[UIColor grayColor] duration:0.5];
        STMyScene *scene = [[STMyScene alloc] initWithSize:self.view.bounds.size mode:mode];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition: reveal];
    }
}

@end
