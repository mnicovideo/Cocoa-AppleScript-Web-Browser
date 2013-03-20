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
        set cookieStorage to sharedHTTPCookieStorage() of current application's NSHTTPCookieStorage
        tell cookieStorage to setCookieAcceptPolicy_(current application's NSHTTPCookieAcceptPolicyOnlyFromMainDocumentDomain)
        --tell cookieStorage to setCookieAcceptPolicy_(current application's NSHTTPCookieAcceptPolicyNever)
        --tell cookieStorage to setCookieAcceptPolicy_(current application's NSHTTPCookieAcceptPolicyAlways)
        set webPrefs to standardPreferences() of current application's WebPreferences
        tell webPrefs to setLocalStorageEnabled_(1)
        tell webPrefs to setDatabasesEnabled_(1)
        tell webPrefs to setDeveloperExtrasEnabled_(boolForKey_("developer") of standardUserDefaults() of current application's NSUserDefaults)
        tell webPrefs to setOfflineWebApplicationCacheEnabled_(1)
        tell webPrefs to setWebGLEnabled_(1)
        tell webView to setPreferences_(webPrefs)
        tell webView to setApplicationNameForUserAgent_("CocoaWebBrowser Version/0.0.1 Safari/536.28.10")
        tell webView to setGroupName_("CocoaWebBrowser")
        
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