//
//  STNoteHelper.m
//  steps
//
//  Created by flav on 10/05/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "STNoteHelper.h"
#import "STNoteSpriteNode.h"


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
    
    NSUInteger n = (mode == EASY) ? 4 : (mode == MEDIUM) ? 5 : 6;
    
    for (NSUInteger i = 0; i < n; ++i)
    {
        //randoms sur des sons
        //randoms sur les images
        [buttons addObject:[[STNoteSpriteNode alloc] initWithName:[NSString stringWithFormat:@"note%lu", i] withValue:[NSNumber numberWithInteger:i] withSound:@"sound1"]];
    }
    
    return buttons;
}

@end