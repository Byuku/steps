
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

+ (NSMutableArray *) initButtonsArray:(GameMode) mode
{
    NSMutableArray * buttons = [[NSMutableArray alloc] init];
    
    NSUInteger n = (mode == EASY) ? 3 : (mode == MEDIUM) ? 5 : 7;
    NSUInteger randSound = 0;
    NSUInteger randNote = 0;

    NSMutableArray * sounds = [[STFileHelper listFile:@"self ENDSWITH '.mp3'"] mutableCopy];
    NSMutableArray * imageButton = [[STFileHelper listFile:@"self contains[c] 'space' AND self ENDSWITH '.png'"] mutableCopy
                                    ];
    
    for (NSUInteger i = 0; i < n; ++i)
    {
        randSound = (arc4random() % [sounds count]);
        randNote = (arc4random() % [imageButton count]);
        
        [buttons addObject:[[STNoteSpriteNode alloc] initWithValue:imageButton[randNote] withSound:sounds[randSound]]];
    
        [sounds removeObjectAtIndex:randSound];
        [imageButton removeObjectAtIndex:randNote];
        
    }
    
    return buttons;
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

    
}

@end