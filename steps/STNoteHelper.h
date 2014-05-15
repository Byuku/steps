//
//  STNoteHelper.h
//  steps
//
//  Created by flav on 10/05/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "STMyScene.h"

@interface STNoteHelper : NSObject

typedef enum {
    EASY = 0,
    MEDIUM,
    HARD,
}GameMode;

+ (void) shuffle:(NSMutableArray *) notes;
+ (NSMutableArray *) initSequence:(NSMutableArray *) buttons;
+ (void) randomizeSound:(NSMutableArray *) buttons;
+ (NSArray *) createPianoNote:(CGRect) frame;
+ (NSMutableArray *) createNote:(GameMode) mode :(NSMutableArray *)PNote;
+ (NSArray *) createStaves:(SKSpriteNode *)pNote :(CGRect) frame;
+ (void) addNoteIntoSequence:(NSMutableArray *)notes withSequence:(NSMutableArray *)sequence withScene:(STMyScene *)scene;
+ (void)updateActionIntoSequence:(NSMutableArray *)sequence;


@end
