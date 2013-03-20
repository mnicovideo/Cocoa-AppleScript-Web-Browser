#import "OSXSound.h"

@implementation OSXSound

- (void) play:(NSString*) file
{
    //NSURL* fileUrl  = [NSURL fileURLWithPath:[[Utils sharedInstance] pathForResource:file]];
	//DebugNSLog(@"Sound file:%@", [fileUrl description]);
	//NSSound* sound = [[NSSound alloc] initWithContentsOfURL:fileUrl byReference:YES];
	//[sound play];
    NSLog(@"Not impliment yat.");
}

- (void) playSystem:(NSString*) name
{
    NSSound *systemSound = [NSSound soundNamed:name];
	[systemSound play];
}

+ (NSString*) webScriptNameForSelector:(SEL)selector
{
	id	result = nil;
	if (selector == @selector(playSystem:))
        result = @"playSystem";
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
