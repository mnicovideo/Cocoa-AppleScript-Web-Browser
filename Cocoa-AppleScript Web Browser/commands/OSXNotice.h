#import <Foundation/Foundation.h>

#define APP_NOTICE_NOTIFICATION @"Notice"

@interface OSXNotice : NSObject <NSUserNotificationCenterDelegate>

- (void) notify:(NSDictionary*)message;
+ (BOOL) available;

@end
