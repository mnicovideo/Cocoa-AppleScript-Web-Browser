#import "OSXConsole.h"

@implementation OSXConsole

- (void) log:(NSString*) message
{
    NSLog(@"JavaScript console: %@", message);
}

+ (NSString*) webScriptNameForSelector:(SEL)selector
{
	id	result = nil;
	if (selector == @selector(log:))
        result = @"log";
	return result;
}

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return NO;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return NO;
}

@end
