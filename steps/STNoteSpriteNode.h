//
//  STNoteSpriteNode.h
//  steps
//
//  Created by flav on 10/05/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface STNoteSpriteNode : SKSpriteNode

@property (nonatomic, strong) NSString *soundPath;
@property (nonatomic, strong) NSNumber * value;

- (id)initWithName:(NSString *)name withValue:(NSNumber *)value withSound:(NSString *)soundPath;

@end
