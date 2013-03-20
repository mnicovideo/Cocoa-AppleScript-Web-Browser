#import "OSXApp.h"

@implementation OSXApp

- (void) activate
{
    [NSApp activateIgnoringOtherApps:YES];
}

- (void) terminate
{
    [NSApp terminate:nil];
}

- (void) hide
{
    [NSApp hide:nil];
}

- (void) unhide
{
    [NSApp unhide:nil];
}

- (void) beep
{
    NSBeep();
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
