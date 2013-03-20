#import <Foundation/Foundation.h>

@interface OSXSound : NSObject

- (void) play:(NSString*) file;
- (void) playSystem:(NSString*) name;

@end
