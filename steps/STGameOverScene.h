//
//  STGameOverScene.h
//  steps
//
//  Created by Tevy CHANH on 12/05/14.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ModeEnum.h"

@interface STGameOverScene : SKScene

-(id)initWithSize:(CGSize)size mode:(GameMode)level score:(NSUInteger)player_score;

@end
