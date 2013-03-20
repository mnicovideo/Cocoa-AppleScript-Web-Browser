#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

#import "OSXApp.h"
#import "OSXDock.h"
#import "OSXNotice.h"
#import "OSXPath.h"
#import "OSXSound.h"
#import "OSXWindow.h"

@interface OSX : NSObject

@property (nonatomic, retain) OSXApp *app;
@property (nonatomic, retain) OSXDock *dock;
@property (nonatomic, retain) OSXNotice *notice;
@property (nonatomic, retain) OSXPath *path;
@property (nonatomic, retain) OSXSound *sound;
@property (nonatomic, retain) OSXWindow *window;

- (id) initWithWebView:(WebView *) view;

@end
