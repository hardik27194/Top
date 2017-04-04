//
//  TopBackendLessConfiguration.h
//  TopFramework
//
//  Created by Jacopo Pappalettera on 19/03/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface TopBackendLessConfiguration : NSObject
@property (nonnull,assign) Class topObjectClass;
@property (nonnull,assign) Class topPageClass;
@property (nonatomic,strong) NSString *topStickerId;

+(instancetype)initWithAppId:(NSString *)appIDKey
                      secret:(NSString *)secretKey
                     version:(NSString *)versionKey;

@end

NS_ASSUME_NONNULL_END
