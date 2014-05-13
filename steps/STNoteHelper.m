
//
//  STNoteHelper.m
//  steps
//
//  Created by flav on 10/05/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "STNoteHelper.h"
#import "STNoteSpriteNode.h"
#import "STFileHelper.h"

@implementation STNoteHelper

+ (void) shuffle:(NSMutableArray *) sequence
{
    NSUInteger randInt = 0;

    for (NSUInteger i = 0; i < [sequence count]; ++i)
    {
        randInt = (arc4random() % ([sequence count] - i)) + i;
        [sequence exchangeObjectAtIndex:i withObjectAtIndex:randInt];
    }
}

+ (NSMutableArray *) initSequence:(NSMutableArray *) buttons
{
    NSMutableArray *sequence = [[NSMutableArray alloc] init];
    NSUInteger randInt = 0;

    for (NSUInteger i = 0; i < [buttons count]; ++i)
    {
        randInt = (arc4random() % [buttons count]);
        [sequence addObject:[(STNoteSpriteNode*)buttons[randInt] value]];
    }
    
    return (sequence);
}

+ (void) randomizeSound:(NSMutableArray *) buttons
{
    NSUInteger randSound = 0;

    NSMutableArray * sounds = [[STFileHelper listFile:@"self ENDSWITH '.mp3'"] mutableCopy];

    for (NSUInteger i = 0; i < [buttons count]; ++i)
    {
        randSound = (arc4random() % [sounds count]);
        
        STNoteSpriteNode * note = [buttons objectAtIndex:i];
        note.soundPath = sounds[randSound];
        [sounds removeObjectAtIndex:randSound];
    }
    sounds = nil;
}

+ (NSMutableArray *) createNote:(GameMode) mode :(NSMutableArray *)PNotes
{
    NSMutableArray * buttons = [[NSMutableArray alloc] init];
    
    NSUInteger n = (mode == EASY) ? 3 : (mode == MEDIUM) ? 5 : 7;
    NSUInteger randSound = 0;
    NSUInteger randNote = 0;
    
    NSMutableArray * sounds = [[STFileHelper listFile:@"self ENDSWITH '.mp3'"] mutableCopy];
    NSMutableArray * imageButton = [[STFileHelper listFile:@"self contains[c] 'note' AND self ENDSWITH '.png'"] mutableCopy];
    
    SKSpriteNode *pnote = PNotes[0];
    
    NSDictionary * positionNotes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithDouble:pnote.position.y + pnote.size.height/4],imageButton[0],
                                    [NSNumber numberWithDouble:pnote.position.y],imageButton[1],
                                    [NSNumber numberWithDouble:pnote.position.y - pnote.size.height/4],imageButton[2],
                                    [NSNumber numberWithDouble:pnote.position.y],imageButton[3],
                                    [NSNumber numberWithDouble:pnote.position.y + pnote.size.height/4],imageButton[4],
                                    [NSNumber numberWithDouble:pnote.position.y],imageButton[5],
                                    [NSNumber numberWithDouble:pnote.position.y - pnote.size.height/4],imageButton[6],
                                    nil];
    
    for (NSUInteger i = 0; i < n; ++i)
    {
        randSound = (arc4random() % [sounds count]);
        randNote = (arc4random() % [imageButton count]);
        
        STNoteSpriteNode * note = [[STNoteSpriteNode alloc] initWithValue:imageButton[randNote] withSound:sounds[randSound]];
        
        pnote = PNotes[randNote];
        note.position = CGPointMake(pnote.position.x , [positionNotes[note.value] doubleValue]);
        [buttons addObject:note];
        
        [sounds removeObjectAtIndex:randSound];
        [imageButton removeObjectAtIndex:randNote];
        [PNotes removeObjectAtIndex:randNote];
    }
    
    PNotes = nil;
    imageButton = nil;
    sounds = nil;
    
    return buttons;
}

+ (NSArray *) createPianoNote:(CGRect) frame
{
    NSMutableArray * array = [NSMutableArray new];
    float x = 11;
    
    NSArray* imagesNote = [STFileHelper listFile:@"self contains[c] 'b-' AND self ENDSWITH '.png'"];
    
    for (NSUInteger i = 0; i < [imagesNote count]; ++i)
    {
        SKSpriteNode * b = [[SKSpriteNode alloc] initWithImageNamed:[imagesNote objectAtIndex:i]];
        
        b.name = [imagesNote objectAtIndex:i];
        b.size = CGSizeMake(frame.size.width/9, frame.size.height/2);
        
        x += b.size.width/2;
        b.position = CGPointMake(x, b.size.height/2);
        x+= b.size.width/1.3;
        
        b.zPosition = 0;
        [array addObject:b];
        b = nil;

    }
    return [NSArray arrayWithArray:array];
}

+ (NSArray *) createStaves:(SKSpriteNode *)pNote :(CGRect) frame
{
    
    NSMutableArray *array = [NSMutableArray new];
    SKSpriteNode *line;
    
    for (NSUInteger i = 0; i < 3; ++i) {
        line = [[SKSpriteNode alloc] initWithImageNamed:@"la_linea"];
        line.size = CGSizeMake(frame.size.width, 17);
        line.zPosition = 1;
        [array addObject:line];
    }
    
    line = array[0];
    line.position = CGPointMake(line.size.width/2, (pNote.position.y + pNote.size.height/2) - line.size.height/4);
    
    line = array[1];
    line.position = CGPointMake(line.size.width/2, pNote.position.y);
    
    line = array[2];
    line.position = CGPointMake(line.size.width/2, (pNote.position.y - pNote.size.height/2) + line.size.height/6);
    
    line = nil;
    
    return [NSArray arrayWithArray:array];
}




@end