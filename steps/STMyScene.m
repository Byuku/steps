//
//  STMyScene.m
//  steps
//
//  Created by flav on 10/05/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "STMyScene.h"
#import "STNoteSpriteNode.h"
#import "STNoteHelper.h"
#import "STFileHelper.h"
#import "STGameOverScene.h"

@implementation STMyScene
{
    NSMutableArray * notes;
    NSMutableArray * sequence;
    NSUInteger indexSeq;
    NSUInteger score;
    GameMode mode;
}

-(id)initWithSize:(CGSize)size mode:(GameMode) level {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        mode = level;
        
        [self displayBackground];
        [self displayScore:mode];
        [self displayGame:mode];
        
        sequence = [STNoteHelper initSequence:notes];
        
        [self initSequenceIntoScene:sequence];

        [self runSequence:sequence];
        
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    STNoteSpriteNode *touchedNode = (STNoteSpriteNode *)[self nodeAtPoint:location];
    
        if ([touchedNode.name isEqualToString:@"note"])
        {
            
            if ([touchedNode.value isEqualToString:[(STNoteSpriteNode *)sequence[indexSeq] value]])
            {
                NSLog(@"right");
                [touchedNode runAction:touchedNode.action];
                
                ++indexSeq;
                if (indexSeq == [sequence count])
                {
                    indexSeq = 0;
                    ++score;
                    
                    [STNoteHelper addNoteIntoSequence:notes withSequence:sequence withScene:self];
                    [STNoteHelper shuffle:sequence];
                    [STNoteHelper updateActionIntoSequence:sequence];
                    
                    SKLabelNode * labelscore = (SKLabelNode *)[self childNodeWithName:@"labelscore"];
                    labelscore.text = [NSString stringWithFormat:@"Score : %ld", score];
                    
                    [self runSequence:sequence];
                    
                }
            }
            else
            {                
                SKTransition *reveal = [SKTransition fadeWithColor:[UIColor grayColor] duration:0.5];
                STGameOverScene *scene = [[STGameOverScene alloc] initWithSize:self.view.bounds.size mode:mode score:score];
                scene.scaleMode = SKSceneScaleModeAspectFill;
                [self.view presentScene:scene transition: reveal];
            }
            
            

            
        }
    
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

-(void)displayScore:(GameMode)level {
    
    score = 0;
    
    SKLabelNode *labelScore = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    labelScore.name = @"labelscore";
    labelScore.text = [NSString stringWithFormat:@"Score : %ld", score];
    labelScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    labelScore.fontSize = self.frame.size.height/25;
    labelScore.fontColor = [SKColor whiteColor];
    labelScore.position = CGPointMake(self.frame.size.width/25, self.frame.size.height - self.frame.size.height/10);
    
    [self addChild:labelScore];
    
    SKLabelNode *labelMode = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    labelMode.text = (level == EASY) ? @"Easy" : (level == NORMAL) ? @"Normal" : @"Hard";
    labelMode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    labelMode.fontSize = self.frame.size.height/25;
    labelMode.fontColor = [SKColor whiteColor];
    labelMode.position = CGPointMake(self.frame.size.width/25, self.frame.size.height - self.frame.size.height/7);
    [self addChild:labelMode];

}

- (void) displayGame:(GameMode)level
{
    NSArray * Pnotes = [STNoteHelper createPianoNote:self.frame];
    
    for (NSInteger i = 0; i < [Pnotes count] ; ++i) {
        [self addChild:[Pnotes objectAtIndex:i]];
    }
    
    notes = [STNoteHelper createNote:level :[Pnotes mutableCopy]];
    
    for (NSInteger i = 0; i < [notes count] ; ++i) {
        [self addChild:[notes objectAtIndex:i]];
    }
        
    NSArray * staves = [STNoteHelper createStaves:Pnotes[0] :self.frame];
    for (NSInteger i = 0; i < [staves count] ; ++i) {
        [self addChild:[staves objectAtIndex:i]];
    }

}

- (void) initSequenceIntoScene:(NSMutableArray *)arraySeq
{
    STNoteSpriteNode *seqNote;
    
    for (NSUInteger i = 0; i < [arraySeq count]; ++i)
    {
        seqNote = (STNoteSpriteNode*)[arraySeq objectAtIndex:i];
        seqNote.alpha = 0;
        seqNote.action = [SKAction sequence:@[[SKAction fadeInWithDuration:i+1],
                                              [SKAction fadeOutWithDuration:i+2]]];
        
        seqNote.size = CGSizeMake(self.frame.size.width/9 + (self.frame.size.width/9)/10, self.frame.size.width/9);
        [self addChild:seqNote];
    }

}

- (void) runSequence:(NSMutableArray *)arraySeq
{
    
    NSMutableArray * seqAction = [NSMutableArray new];
    STNoteSpriteNode *seqNote;
    NSUInteger randX = 0;
    NSUInteger randY = 0;
    
    for (NSUInteger i = 0; i < [arraySeq count]; ++i)
    {
        seqNote = (STNoteSpriteNode*)[arraySeq objectAtIndex:i];
        [seqAction addObject:[SKAction playSoundFileNamed:seqNote.soundPath waitForCompletion:YES]];
       
        
        randX = (arc4random() % ((NSUInteger)self.frame.size.width - (NSUInteger)seqNote.size.width/2 - (NSUInteger)seqNote.size.width/2)) + (NSUInteger)seqNote.size.width/2;
        randY = (arc4random() % ((NSUInteger)self.frame.size.height/2 - (NSUInteger)seqNote.size.height/2 - (NSUInteger)seqNote.size.height/2)) + (NSUInteger)seqNote.size.height/2;

        
        seqNote.position = CGPointMake(randX,self.frame.size.height/2 + randY);
        
        
        [seqNote runAction:seqNote.action];
        
        NSLog(@"rep -> %@", seqNote.value);

    }
    
    [self runAction:[SKAction sequence:seqAction]];


}

//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint location = [touch locationInNode:self];
//    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
//    
//    if ([touchedNode.name isEqualToString:@"note"])
//    {
//        touchedNode.position = CGPointMake(touchedNode.position.x , touchedNode.position.y + 2);
//    }
//    
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint location = [touch locationInNode:self];
//    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:location];
//    
//    if ([touchedNode.name isEqualToString:@"note"])
//    {
//        touchedNode.position = CGPointMake(touchedNode.position.x , touchedNode.position.y + 2);
//        
//        NSString *burstPath =
//        [[NSBundle mainBundle]
//         pathForResource:@"MyParticle" ofType:@""];
//        
//        SKEmitterNode *burstNode =
//        [NSKeyedUnarchiver unarchiveObjectWithFile:burstPath];
//        
//        burstNode.position = CGPointMake(touchedNode.position.x, 200);
////        burstNode.particleColorSequence = nil;
////        burstNode.particleColorBlendFactor = 1;
////        burstNode.particleColor = [SKColor redColor];
//        
//        
//            [burstNode runAction:[SKAction moveToY:1000 duration:3]];
//        
//        [self addChild:burstNode];
//    }
//
//}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
