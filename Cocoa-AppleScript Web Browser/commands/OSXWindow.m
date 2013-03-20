#import "OSXWindow.h"

@implementation OSXWindow

@synthesize window;

- (id) initWithWindow:(NSWindow *) win
{
    self = [super init];
    self.window = win;
    return self;
}

- (void) move:(NSDictionary *)properties
{
    NSRect frame = self.window.frame;
    frame.origin.x = [[properties valueForKey:@"x"] doubleValue];
    frame.origin.y = [[properties valueForKey:@"y"] doubleValue];
    [self.window setFrame:frame display:YES animate:YES];
}

- (void) resize:(NSDictionary *) properties
{
    NSRect frame = self.window.frame;
    frame.size.width = [[properties valueForKey:@"width"] doubleValue];
    frame.size.height = [[properties valueForKey:@"height"] doubleValue];
    [self.window setFrame:frame display:YES animate:YES];
}

- (void) setFrame:(NSDictionary *) properties
{
    NSRect frame = self.window.frame;
    frame.origin.x = [[properties valueForKey:@"x"] doubleValue];
    frame.origin.y = [[properties valueForKey:@"y"] doubleValue];
    frame.size.width = [[properties valueForKey:@"width"] doubleValue];
    frame.size.height = [[properties valueForKey:@"height"] doubleValue];
    [self.window setFrame:frame display:YES animate:YES];
}


+ (NSString*) webScriptNameForSelector:(SEL)selector
{
	id	result = nil;
	if (selector == @selector(setFrame:)){
        result = @"setFrame";
    }
	else if (selector == @selector(move:)){
        result = @"move";
    }
    else if (selector == @selector(resize:)){
        result = @"resize";
    }
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
