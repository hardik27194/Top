//
//  TopAccount.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 24/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopUser.h"

@implementation TopUser

+(BOOL)validateAccount:(TopUser *)account{
    return account.name != nil &&
           account.email != nil &&
           account.token != nil &&
           account.created != nil;
}
+(TopUser *)initializeAccountWithData:(NSDictionary *)userData{
    TopUser *account = [[TopUser alloc]init];
    account.name = userData[@"name"];
    account.email = userData[@"email"];
    account.token = userData[@"user-token"];
    account.created = userData[@"created"];
    account.lastLogin = userData[@"lastLogin"];
    
    BOOL validated = [TopUser validateAccount:account];
    
    return validated ? account : nil;
}

@end
