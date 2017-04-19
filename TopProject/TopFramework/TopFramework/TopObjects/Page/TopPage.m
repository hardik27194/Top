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
    //[description appendString:[NSString stringWithFormat:@"topObjects : %@ \n",self.topObjects]];
    [description appendString:[NSString stringWithFormat:@"iPhoneLayoutName : %@ \n",self.iPhoneLayoutName]];
    [description appendString:[NSString stringWithFormat:@"iPadLayoutName : %@ \n",self.iPadLayoutName]];
    [description appendString:[NSString stringWithFormat:@"number : %i \n",(int)self.index]];
    [description appendString:@">\n"];
    return description;
    
}
@end
