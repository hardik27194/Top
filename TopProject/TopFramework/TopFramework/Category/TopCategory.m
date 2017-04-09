//
//  TopCategory.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 09/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopCategory.h"

@implementation TopCategory
- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    }
    if (![other isKindOfClass:[TopCategory class]]) {
        return NO;
    }
    
    return [self.objectId isEqualToString:[(TopCategory *)other objectId]];
    
}

- (NSUInteger)hash
{
    return [self.objectId hash];
}
@end
