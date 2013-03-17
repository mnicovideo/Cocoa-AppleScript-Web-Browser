-- see:
-- https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/NSWindowDelegate_Protocol/Reference/Reference.html
--
-- TODO:
-- documentViewにて動的なheight?を設定しているとそれを含めたheightが取得できない。解決方法を見つける。

script WindowDelegate
    property parent : class "NSObject"
    
    property webView : missing value
    property status : missing value
    
    property fullScreenMode : false
    
    on windowWillResize_toSize_(sender,frame)
        set windowWidth to width of |size| of frame() of sender
        try
            tell status to setPreferredMaxLayoutWidth_(windowWidth - 40)
        end try
        return frame
    end
    
    on window_willUseFullScreenPresentationOptions_(appWindow, proposedOptions)
        --return (NSApplicationPresentationFullScreen | NSApplicationPresentationHideDock | NSApplicationPresentationAutoHideMenuBar | NSApplicationPresentationAutoHideToolbar);
        return 3078
    end
    
    on windowWillEnterFullScreen_(aNotification)
        set fullScreenMode to true
    end
    
    on windowDidExitFullScreen_(aNotification)
        set fullScreenMode to false
    end
    
    on windowWillUseStandardFrame_defaultFrame_(appWindow, defaultFrame)
        if fullScreenMode then
            return defaultFrame
        end if
        
        set appWindowFrame to frame() of appWindow
        set webViewFrame to frame() of webView
        set documentViewFrame to frame() of documentView of frameView of mainFrame of webView
        set mainScreenFrame to frame() of mainScreen of current application's NSScreen
        
        set x to x of origin of appWindowFrame
        set y to y of origin of appWindowFrame
        
        set windowHeadHeight to height of |size| of appWindowFrame - height of |size| of webViewFrame
        set width to width of |size| of documentViewFrame
        set height to height of |size| of documentViewFrame + windowHeadHeight
        
        set screenWidth to width of |size| of mainScreenFrame
        
        if x < 0 then
            set x to 0
        else if x + width > screenWidth then
            set x to screenWidth - width
        end if
        
        tell current application's NSMakeRect to NSMakeRect(x, y, width, height)
        return result
    end
    
end script