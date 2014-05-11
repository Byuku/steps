//
//  STNoteSpriteNode.m
//  steps
//
//  Created by flav on 10/05/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "STNoteSpriteNode.h"

@implementation STNoteSpriteNode

- (id)initWithValue:(NSString *)value withSound:(NSString *)soundPath
{
    self = [super init];
    
    if (self)
    {
        self = [STNoteSpriteNode spriteNodeWithImageNamed:value];
        self.name = value;
        self.value = value;
        self.soundPath = soundPath;
    }
    
    return self;
}

@end
