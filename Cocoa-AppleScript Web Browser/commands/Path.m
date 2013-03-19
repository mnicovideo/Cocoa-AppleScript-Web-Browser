#import "Path.h"

@implementation Path

//@synthesize bundle,resource;

- (NSString *) bundle
{
    return [[NSBundle mainBundle] bundlePath];
}

- (NSString *) resource
{
    return [[NSBundle mainBundle] resourcePath];
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
