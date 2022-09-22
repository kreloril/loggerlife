//
//  MSMobileCoreResourceDelegate.h
//  MSMobilecore
//
//  Created by John Mulvey on 12/1/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSMobileCoreResourceDelegate <NSObject>
-(NSString*)resourceBinding;
-(bool)enableLogging;
-(NSString*)persistanceDatabaseName;
-(NSString*)dataBaseEncryptionKey;
-(NSString*)databaseInfoFilePath;
-(NSString*)contentDatabaseName;
-(NSString*)defaultLanguage;
@end

NS_ASSUME_NONNULL_END
