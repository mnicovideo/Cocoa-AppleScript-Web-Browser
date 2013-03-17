-- see:
-- https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/WebKit/Classes/WebView_Class/Reference/Reference.html

script WebViewHelper
    property parent : class "NSObject"
    
    property webView : missing value
    
    property offlineContents : "public/index.html"
    property onlineContents : "http://www.apple.com/"
    
    on setWebView_(webView)
        set my webView to webView
    end
    
    on setOfflineContents_(contents)
        set my offlineContents to contents
    end
    
    on setOnlineContents_(contents)
        set my onlineContents to contents
    end
    
    on loadContents()
        set mainBundle to mainBundle of current application's NSBundle
        set resourceURL to resourceURL of mainBundle
        set offlineContentsPath to resourcePath of mainBundle as text & "/" & offlineContents
        tell application "Finder" to exists offlineContentsPath as POSIX file
        if result is true then
            tell current application's NSURL to URLWithString_relativeToURL_(offlineContents, resourceURL)
            set contentsURL to absoluteString of result
        else
            --log "WARNING: offline contents is not exists, try product clean & build."
            set contentsURL to onlineContents
        end if
        tell webView to setMainFrameURL_(contentsURL)
    end
    
end script