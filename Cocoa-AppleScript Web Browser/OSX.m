#import "OSX.h"

@implementation OSX

@synthesize app;
@synthesize dock;
@synthesize notice;
@synthesize path;
@synthesize sound;
@synthesize window;

- (id) initWithWebView:(WebView *) view
{
    self = [super init];
    self.app = [OSXApp new];
    self.dock = [OSXDock new];
    self.notice = [OSXNotice new];
    self.path = [OSXPath new];
    self.sound = [OSXSound new];
    self.window = [[OSXWindow alloc] initWithWindow:[view window]];
    return self;
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
