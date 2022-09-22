//
//  MSFeatureLifeLogger.m
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 12/1/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//
#define ENTRY_KEY @"ENTRY_KEY"


@import GoogleMobileAds;


#import "MSFeatureLifeLogger.h"
#import "MSFeatureLifeLoggerScreens.h"

@interface MSFeatureLifeLogger()
@end

@implementation MSFeatureLifeLogger

+(MSFeatureLifeLogger*) instance {
    static MSFeatureLifeLogger* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MSFeatureLifeLogger alloc]  init];
        [MSLogger log:@"MSFeatureLifeLogger started"];
        instance.userSettings = [[MSLifeLoggerUserSettings alloc] init];
        instance.featureDataBase = [[MSFeatureDatabase alloc] init];
    });
    
    return instance;
}
-(UIView*)createBannerRequest:(UIViewController*)viewc screen:(AddBannerScreen)screen {
   
    if (self.userSettings.hasBannerAdsDisabled == true)
        return nil;
    

   GADBannerView* bannerView =  [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];

    NSString* addBanner = nil;
    
    switch (screen) {
        case AddBannerScreenAbout: {
            addBanner = @"ca-app-pub-5690864134174270/6889821768";
            break;
        }
        case AddBannerScreenChangeOrder: {
            addBanner = @"ca-app-pub-5690864134174270/8842387054";
            break;
        }
        case AddBannerScreenEditCatagory:{
            addBanner = @"ca-app-pub-5690864134174270/6216223718";
            break;
        }
        case AddBannerScreenEntryScreen:{
            addBanner = @"ca-app-pub-5690864134174270/5576740090";
            break;
        }
        case AddBannerScreenMain:{
            addBanner = @"ca-app-pub-5690864134174270/1618503156";
            break;
        }
    }
    
    bannerView.adUnitID = addBanner;
    bannerView.rootViewController = viewc;
    GADRequest* request = [GADRequest request];
#if TARGET_OS_SIMULATOR
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ kGADSimulatorID ];
#endif
    [bannerView loadRequest:request];
    return bannerView;
 
}
+(NSString*)googleAddSenseIntestinal1 {
    return @"ca-app-pub-5690864134174270/2292031397";
}
+(NSString*)googleAddSenseIdentification {
    return @"ca-app-pub-5690864134174270~9653299055";
}

-(NSString*)resourceBinding {
    return @"lifeloggerresource";
}
-(bool)enableLogging {
    return true;
}

-(NSString*)persistanceDatabaseName {
    NSString* dbname =  @"lifelogger.sqlite";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:dbname];
    
    return path;
}

-(NSString*)dataBaseEncryptionKey {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}
-(NSString*)databaseInfoFilePath {
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    return [bundle pathForResource:@"MasterDB" ofType:@"plist"];
}

- (nonnull NSString *)contentDatabaseName {
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    return [bundle pathForResource:@"dbcmskeys" ofType:@"db"];
}

- (nonnull NSString *)defaultLanguage {
    return @"en-us";
}

@end
