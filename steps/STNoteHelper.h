//
//  STNoteHelper.h
//  steps
//
//  Created by flav on 10/05/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNoteHelper : NSObject

typedef enum {
    EASY = 0,
    MEDIUM,
    HARD,
}GameMode;

+ (void) shuffle:(NSMutableArray *) notes;
+ (NSMutableArray *) initSequence:(NSMutableArray *) buttons;
+ (NSMutableArray *) initButtonsArray:(GameMode) mode;


@end
