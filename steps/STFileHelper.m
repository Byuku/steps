//
//  STFileHelper.m
//  steps
//
//  Created by flav on 11/05/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "STFileHelper.h"

@implementation STFileHelper

+ (NSArray *) listFile:(NSString *) query;
{
    
    NSString *path = [[NSBundle mainBundle] resourcePath];

    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    NSArray *contents = [fm contentsOfDirectoryAtPath:path error:&error];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    
    contents = [contents filteredArrayUsingPredicate:predicate];
    
    return contents;
}


@end
