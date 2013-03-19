#import <Foundation/Foundation.h>
#import "App.h"
#import "Path.h"

@interface OSX : NSObject

@property (nonatomic, retain) App* app;
@property (nonatomic, retain) Path* path;

- (OSX *)init;

@end
