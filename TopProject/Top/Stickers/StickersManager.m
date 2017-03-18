//
//  StickersManager.m
//  Top
//
//  Created by Jacopo Pappalettera on 18/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "StickersManager.h"
#import "Backendless.h"


@implementation StickersManager
- (NSArray *)loadAllStickers{
    id <IDataStore> stickers = [backendless.persistenceService of:[Sticker class]];
    BackendlessCollection *c = [stickers find];
    return c.data;
}
-(void)saveSticker{
    Responder *responder = [Responder responder:self
                             selResponseHandler:@selector(responseHandler:) selErrorHandler:
                            @selector(errorHandler:)];
    
    Sticker *prova = [[Sticker alloc]init];
    prova.title = @"provola";
    prova.desc = @"description";
    
    prova.number = 20;
    id<IDataStore> dataStore = [backendless.persistenceService of:[Sticker class]];
    [dataStore save:prova responder:responder];
    
    
}
-(id)responseHandler:(id)response
{
    NSLog(@"%@", response);
    return response;
}
-(id)errorHandler:(Fault *)fault
{
    NSLog(@"%@", fault.detail);
    return fault;
}

@end
