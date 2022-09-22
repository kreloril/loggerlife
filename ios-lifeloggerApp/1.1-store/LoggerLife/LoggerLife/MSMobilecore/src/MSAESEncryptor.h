//
//  MSAESEncryptor.h
//  MSMobilecore
//
//  Created by John Mulvey on 12/7/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSAESEncryptor : NSObject
+(NSData*) encryptData:(NSData*)data withKey:(NSData*)key;
+(NSData*) decryptData:(NSData*)data withKey:(NSData*)key;
@end

NS_ASSUME_NONNULL_END
