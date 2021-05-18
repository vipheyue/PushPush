//
//  NotificationService.m
//  PushServiceExt
//
//  Created by YC X on 2021/5/16.
//

#import "NotificationService.h"

#import "RlmData.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = @"";
    
    RlmData *data = [[RlmData alloc] initWithValue:@{@"acceptTime":[self getCurrentTimes], @"contentMsg":self.bestAttemptContent.body}];
    
    NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.smsgroupExt"];
    NSURL *fileURL = [groupURL URLByAppendingPathComponent:@"push.realm"];
    
    RLMRealmConfiguration *config = [[RLMRealmConfiguration alloc] init];
    config.fileURL = fileURL;
    config.schemaVersion = 1.0;
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {

    };
    RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:nil];

    //    开放RLMRealm事务
    [realm beginWriteTransaction];

    //    添加到数据库 me为RLMObject
    [realm addObject:data];

    //    提交事务
    [realm commitWriteTransaction];
    
    self.contentHandler(self.bestAttemptContent);
}

- (NSString *)getCurrentTimes
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
