#import <Foundation/Foundation.h>

@interface OSXWindow : NSObject

@property NSWindow *window;

- (id) initWithWindow:(NSWindow *) window;
- (void) move:(NSDictionary *) properties;
- (void) resize:(NSDictionary *) properties;
- (void) setFrame:(NSDictionary *) properties;

@end
