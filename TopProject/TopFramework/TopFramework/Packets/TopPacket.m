//
//  TopPacket.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 01/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopPacket.h"
@interface TopPacket (){
    NSArray <NSNumber *> *_stickers;
}
@end

@implementation TopPacket
- (instancetype)initWithArray:(NSArray <NSNumber *>*)stickers
{
    self = [super init];
    if (self) {
        _stickers = stickers;
    }
    return self;
}
-(NSArray *)stickers{
    return _stickers;
}
-(NSString *)description{
    NSMutableString *description = [[NSMutableString alloc]initWithString:@"<TopPacket : \n"];
    for (NSNumber *number in _stickers) {
        [description appendString:[NSString stringWithFormat:@" - %i - \n",[number integerValue]]];
    }
    [description appendString:@" >"];
    
    return description;
}
@end
