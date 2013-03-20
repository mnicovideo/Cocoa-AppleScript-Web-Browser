#import "OSXNotice.h"

@implementation OSXNotice

- (void) notify:(NSDictionary *) message
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    [notification setTitle:[message valueForKey:@"title"]];
    [notification setInformativeText:[message valueForKey:@"content"]];
    [notification setDeliveryDate:[NSDate dateWithTimeInterval:0 sinceDate:[NSDate date]]];
    [notification setSoundName:NSUserNotificationDefaultSoundName];
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center scheduleNotification:notification];
}

+ (BOOL) available
{
    return [NSUserNotificationCenter respondsToSelector:@selector(defaultUserNotificationCenter)];
}

+ (NSString*) webScriptNameForSelector:(SEL) selector
{
	id	result = nil;
	if (selector == @selector(notify:))
		result = @"notify";
	return result;
}

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    if (selector == @selector(notify:))
        return NO;
    return YES;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return YES;
}

@end
