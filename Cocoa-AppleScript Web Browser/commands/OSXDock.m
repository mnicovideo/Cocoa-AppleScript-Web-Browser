#import "OSXDock.h"

@implementation OSXDock

@synthesize badge;

- (NSString *) badge
{
    NSDockTile *tile = [[NSApplication sharedApplication] dockTile];
    return [tile badgeLabel];
}

- (void) setBadge:(NSString*) value
{
    NSDockTile *tile = [[NSApplication sharedApplication] dockTile];
    [tile setBadgeLabel:value];
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
