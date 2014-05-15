//
//  STMyScene.m
//  steps
//
//  Created by flav on 10/05/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "STMyScene.h"
#import "STNoteHelper.h"
#import "STNoteSpriteNode.h"

#import "STFileHelper.h"

@implementation STMyScene
{
    NSMutableArray * notes;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        GameMode mode = MEDIUM;
        
        
        //display background
        SKSpriteNode *background = [[SKSpriteNode alloc] initWithImageNamed:@"bg2"];
        background.zPosition = -1;
        background.position = CGPointMake(0, 0);
        background.size = self.frame.size;
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background];
        

        
        //display score

         SKLabelNode *labelScore = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        labelScore.text = [NSString stringWithFormat:@"Score : %d", 100];
        labelScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        labelScore.fontSize = self.frame.size.height/25;
        labelScore.fontColor = [SKColor whiteColor];
        labelScore.position = CGPointMake(self.frame.size.width/25, self.frame.size.height - self.frame.size.height/10);
        
        [self addChild:labelScore];
        
        SKLabelNode *labelMode = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        labelMode.text = (mode == EASY) ? @"Easy" : (mode == MEDIUM) ? @"Medium" : @"Hard";
        labelMode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        labelMode.fontSize = self.frame.size.height/25;
        labelMode.fontColor = [SKColor whiteColor];
        labelMode.position = CGPointMake(self.frame.size.width/25, self.frame.size.height - self.frame.size.height/7);
        [self addChild:labelMode];
        
        // display game
        NSArray * Pnotes = [STNoteHelper createPianoNote:self.frame];
        
        for (NSInteger i = 0; i < [Pnotes count] ; ++i) {
            [self addChild:[Pnotes objectAtIndex:i]];
        }

        notes = [STNoteHelper createNote:mode :[Pnotes mutableCopy]];
        
        for (NSInteger i = 0; i < [notes count] ; ++i) {
            [self addChild:[notes objectAtIndex:i]];
        }

        
        NSArray * staves = [STNoteHelper createStaves:Pnotes[0] :self.frame];
        for (NSInteger i = 0; i < [staves count] ; ++i) {
            [self addChild:[staves objectAtIndex:i]];
        }
        
        
        
      

        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
    
        if ([touchedNode.name isEqualToString:@"note"])
        {
            touchedNode.position = CGPointMake(touchedNode.position.x , touchedNode.position.y - 2);
        }
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
    
    if ([touchedNode.name isEqualToString:@"note"])
    {
        touchedNode.position = CGPointMake(touchedNode.position.x , touchedNode.position.y + 2);
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
    
    if ([touchedNode.name isEqualToString:@"note"])
    {
        touchedNode.position = CGPointMake(touchedNode.position.x , touchedNode.position.y + 2);
        
        NSString *burstPath =
        [[NSBundle mainBundle]
         pathForResource:@"MyParticle" ofType:@"sks"];
        
        SKEmitterNode *burstNode =
        [NSKeyedUnarchiver unarchiveObjectWithFile:burstPath];
        
        burstNode.position = CGPointMake(touchedNode.position.x, 200);
//        burstNode.particleColorSequence = nil;
//        burstNode.particleColorBlendFactor = 1;
//        burstNode.particleColor = [SKColor redColor];
        
        
            [burstNode runAction:[SKAction moveToY:1000 duration:3]];
        
        [self addChild:burstNode];
    }

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
