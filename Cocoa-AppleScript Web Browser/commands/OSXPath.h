#import <Foundation/Foundation.h>

@interface OSXPath : NSObject

@property (readonly, copy) NSString *bundle;
@property (readonly, copy) NSString *resource;

- (NSString *) bundle;
- (NSString *) resource;

@end
