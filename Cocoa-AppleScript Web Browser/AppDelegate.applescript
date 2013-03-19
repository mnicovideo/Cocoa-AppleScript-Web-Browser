--
--  AppDelegate.applescript
--  Cocoa-AppleScript Web Browser
--
--  Copyright (c) 2013 mii. All rights reserved.
--

script AppDelegate
    property parent : class "NSObject"
    property WebViewHelper : class "WebViewHelper"
    
    property appWindow : missing value
    property appWindowController : missing value
    property webView : missing value
    
    property offlineContents : "public/index.html"
    property onlineContents : "http://www.yahoo.com/"
    
    on applicationShouldHandleReopen_hasVisibleWindows_(sender, visible)
        if visible is false then
            tell appWindowController to showWindow_(me)
        end if
        return yes
    end applicationShouldHandleReopen_hasVisibleWindows_
    
    on applicationWillFinishLaunching_(aNotification)
        -- Insert code here to initialize your application before any files are opened
        set webView of WebViewHelper to webView
        try
            set offlineContents of WebViewHelper to offlineContents
        end try
        try
            set onlineContents of WebViewHelper to onlineContents
        end try
        tell WebViewHelper to loadContents()
    end applicationWillFinishLaunching_
    
    on applicationShouldTerminate_(sender)
        -- Insert code here to do any housekeeping before your application quits
        return current application's NSTerminateNow
    end applicationShouldTerminate_
    
end script