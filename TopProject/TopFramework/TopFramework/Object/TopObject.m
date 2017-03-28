//
//  TopObject.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopObject.h"


@implementation TopObject
-(NSString *)description{
    NSMutableString *description = [[NSMutableString alloc]initWithString:@"<TopObject :"];
    
    [description appendString:[NSString stringWithFormat:@"title : %@ \n",self.title]];
    [description appendString:[NSString stringWithFormat:@"desc : %@ \n",self.desc]];
    [description appendString:[NSString stringWithFormat:@"image : %@ \n",self.image]];
    [description appendString:[NSString stringWithFormat:@"layoutName : %@ \n",self.rarity]];
    [description appendString:[NSString stringWithFormat:@"rows : %@ \n",self.rows]];
    [description appendString:[NSString stringWithFormat:@"columns : %@ \n",self.columns]];

    [description appendString:@" >"];
    
    return description;
    
}
@end
