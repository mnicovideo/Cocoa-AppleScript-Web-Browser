#import "OSX.h"
#import "App.h"
#import "Path.h"

@implementation OSX

@synthesize app;
@synthesize path;

- (OSX *)init
{
    self.app = [App new];
    self.path = [Path new];
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
