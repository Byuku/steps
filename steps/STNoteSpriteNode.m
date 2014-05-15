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
        self.name = @"note";
        self.value = value;
        self.soundPath = soundPath;
        
        SKAction *fadeInOut = [SKAction sequence:@[[SKAction fadeOutWithDuration:0.1],[SKAction fadeInWithDuration:0.1]]];
       
        self.action = [SKAction group:@[fadeInOut,[SKAction playSoundFileNamed:soundPath waitForCompletion:YES]]];
                       
        self.zPosition = 2;
    }
    
    return self;
}

@end
