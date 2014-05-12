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
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        NSArray * Pnotes = [STNoteHelper createPianoNote:self.frame];
        
        for (NSInteger i = 0; i < [Pnotes count] ; ++i) {
            [self addChild:[Pnotes objectAtIndex:i]];
        }

      notes = [STNoteHelper createNote:HARD :[Pnotes mutableCopy]];
        
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
    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
        
//        [self addChild:sprite];
   // }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
