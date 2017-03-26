//
//  TopPage.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopPage.h"

@implementation TopPage
-(NSString *)description{
    NSMutableString *description = [[NSMutableString alloc]initWithString:@"<TopPage :"];
    
    [description appendString:[NSString stringWithFormat:@"title : %@ \n",self.title]];
    [description appendString:[NSString stringWithFormat:@"desc : %@ \n",self.desc]];
    [description appendString:[NSString stringWithFormat:@"topObjects : %@ \n",self.topObjects]];
    [description appendString:[NSString stringWithFormat:@"layoutName : %@ \n",self.layoutName]];
    [description appendString:[NSString stringWithFormat:@"number : %i \n",(int)self.number]];

    [description appendString:@" >"];
    
    return description;
    
}
@end
