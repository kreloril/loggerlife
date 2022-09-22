//
//  MSAESEncryptor.m
//  MSMobilecore
//
//  Created by John Mulvey on 12/7/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//


#import <CommonCrypto/CommonCryptor.h>
#import "MSLogger.h"
#import "MSAESEncryptor.h"

@interface MSAESEncryptor()

@property NSData* data;
@property NSData* key;

@end

@implementation MSAESEncryptor
+(NSData*) encryptData:(NSData*)data withKey:(NSData*)key {
    MSAESEncryptor* encryptor = [self new];
    encryptor.key = key;
    return [encryptor encrypt:data];
}

+(NSData*) decryptData:(NSData*)data withKey:(NSData*)key {
    MSAESEncryptor* encryptor = [self new];
    encryptor.key = key;
    return [encryptor decrypt:data];
}

-(NSData*) encrypt:(NSData*)data {
    return [self crypt:kCCEncrypt data:data];
}

-(NSData*) decrypt:(NSData*)data {
    return [self crypt:kCCDecrypt data:data];
}

-(NSData*) crypt:(CCOperation)op data:(NSData*)data {
    NSData* result = nil;
    
    // setup key
    unsigned char cKey[kCCKeySizeAES256];
    bzero(cKey, sizeof(cKey));
    [self.key getBytes:cKey length:kCCKeySizeAES256];
    
    // setup iv
    //    char cIv[BacklineBlockSize];
    //    bzero(cIv, BacklineBlockSize);
    
    // setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(op, kCCAlgorithmAES128, kCCOptionPKCS7Padding, cKey, kCCKeySizeAES256, NULL, [data bytes], [data length], buffer, bufferSize, &encryptedSize);
    
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    } else {
        free(buffer);
        [MSLogger log:@"[ERROR] failed to %@|CCCryptoStatus: %d", op == kCCEncrypt ? @"encrypt" : @"decrypt", cryptStatus];
    }
    
    return result;
}
@end
