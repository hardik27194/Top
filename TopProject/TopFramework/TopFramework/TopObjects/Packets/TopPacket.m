//
//  TopPacket.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 01/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopPacket.h"
#import "Chance.h"


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
        [description appendString:[NSString stringWithFormat:@" - %i - \n",(int)[number integerValue]]];
    }
    [description appendString:@" >"];
    
    return description;
}
+ (NSArray<NSNumber *> *)types{
    return nil;
}
@end

@implementation TopSimplePacket

+ (NSArray<NSNumber *> *)types{
    NSNumber *first = @(TopRarityLevel_Common);
    NSNumber *second = @(TopRarityLevel_Uncommon);
    NSNumber *third = @([Chance luck:0]);
    NSNumber *fourth = @(TopRarityLevel_Rare);
    NSNumber *last = @([Chance randomRarity]);
    return @[first,second,third,fourth,last];
}
@end

@implementation TopUncommonPacket

+(NSArray<NSNumber *> *)types{
    NSNumber *first = @(TopRarityLevel_Common);
    NSNumber *second = @(TopRarityLevel_Common);
    NSNumber *third = @(TopRarityLevel_Uncommon);
    NSNumber *fourth = @([Chance luck:1]);
    NSNumber *last = @([Chance randomRarity]);
    return @[first,second,third,fourth,last];
}
@end

@implementation TopRarePacket

+(NSArray<NSNumber *> *)types{
    NSNumber *first = @(TopRarityLevel_Uncommon);
    NSNumber *second = @([Chance luck:1]);
    NSNumber *third = @([Chance luck:2]);
    NSNumber *fourth = @([Chance luck:2]);
    NSNumber *last = @([Chance randomRarity]);
    return @[first,second,third,fourth,last];
}
@end

@implementation TopUltraRarePacket

+(NSArray<NSNumber *> *)types{
    NSNumber *first = @([Chance luck:1]);
    NSNumber *second = @([Chance luck:2]);
    NSNumber *third = @([Chance luck:2]);
    NSNumber *fourth = @([Chance luck:3]);
    NSNumber *last = @([Chance randomRarity]);
    return @[first,second,third,fourth,last];
}
@end

@implementation TopLegendaryPacket
+(NSArray<NSNumber *> *)types{
    NSNumber *first = @([Chance luck:1]);
    NSNumber *second = @([Chance luck:3]);
    NSNumber *third = @([Chance luck:3]);
    NSNumber *fourth = @([Chance luck:4]);
    NSNumber *last = @([Chance randomRarity]);
    return @[first,second,third,fourth,last];
}
@end

@implementation TopRandomPacket

+(NSArray<NSNumber *> *)types{
    NSNumber *first = @([Chance randomRarity]);
    NSNumber *second = @([Chance randomRarity]);
    NSNumber *third = @([Chance randomRarity]);
    NSNumber *fourth = @([Chance randomRarity]);
    NSNumber *last = @([Chance randomRarity]);
    return @[first,second,third,fourth,last];
}
@end
@implementation TopAllCommonPacket

+(NSArray<NSNumber *> *)types{
    NSNumber *first = @(TopRarityLevel_Common);
    NSNumber *second = @(TopRarityLevel_Common);
    NSNumber *third = @(TopRarityLevel_Common);
    NSNumber *fourth = @(TopRarityLevel_Common);
    NSNumber *last = @(TopRarityLevel_Common);
    return @[first,second,third,fourth,last];
}
@end
