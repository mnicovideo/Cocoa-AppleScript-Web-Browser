#import <Foundation/Foundation.h>

@interface OSXDock : NSObject

@property (readwrite, copy) NSString *badge;

- (NSString *) badge;
- (void) setBadge:(NSString*) value;

@end


