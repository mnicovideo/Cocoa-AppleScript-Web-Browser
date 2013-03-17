-- see:
-- https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/WebKit/Classes/WebView_Class/Reference/Reference.html
--
-- TODO:
-- FrameLoadDelegateにて。ウィジェットのような外部JavaScriptを呼び出した場合にwebView:didStartProvisionalLoadForFrame:が反応してしまうのを防ぐ。

script WebViewDelegate
    property parent : class "NSObject"
    
    property locationBar : missing value
    property indicator : missing value
    property status : missing value
    
    -- === ResourceLoadDelegate ======================
    
    on webView_resource_willSendRequest_redirectResponse_fromDataSource_(sender,identifier,request,redirectResponse,dataSource)
        set requestString to absoluteString() of |URL| of request
        tell requestString to rangeOfString_("/___osx-log___/")
        if  |length| of result is 0 then
            return request
        end if
        tell requestString to componentsSeparatedByString_("/_OSX_/")
        set logString to objectAtIndex_(1) of result
        tell logString to stringByReplacingPercentEscapesUsingEncoding_(current application's NSUTF8StringEncoding)
        log "JavaScript console: " & result
    end
    
    -- === FrameLoadDelegate =========================
    
	on webView_didReceiveTitle_forFrame_(sender, title, frame)
		if mainFrame of sender is frame then
			tell |window| of sender to setTitle_(title)
		end if
	end
	
	on webView_didStartProvisionalLoadForFrame_(sender, frame)
        set urlString to absoluteString() of |URL| of request of provisionalDataSource of frame
		tell locationBar to setStringValue_(urlString)
        try
            tell status to setStringValue_(urlString)
        end try
        try
            set |hidden| of indicator to 0
            tell indicator to startAnimation_(sender)
        end try
	end
    
	on webView_didFinishLoadForFrame_(sender, frame)
        try
            tell status to setStringValue_("")
        end try
        try
            tell indicator to stopAnimation_(sender)
            set |hidden| of indicator to 1
        end try
	end
	
    on webView_didFailLoadWithError_forFrame_(sender, anError, frame)
        try
            tell status to setStringValue_("")
        end try
        try
            tell indicator to stopAnimation_(sender)
            set |hidden| of indicator to 1
        end try
    end
    
    -- === UIDelegate ================================
    
    on webView_contextMenuItemsForElement_defaultMenuItems_(sender,element,defaultMenuItems)
        set modifiedMenuItems to {}
        repeat with mItem in mutableCopy() of defaultMenuItems
            if tag() of mItem = 1 then -- new window
                --skip
            else if tag() of mItem = 2 then -- download link
                --skip
            else
                set the end of modifiedMenuItems to mItem
            end if
        end repeat
        return modifiedMenuItems
    end
    
    on webView_mouseDidMoveOverElement_modifierFlags_(sender,elementInformation,modifierFlags)
        set keys to objectForKey_(current application's WebElementLinkURLKey) of elementInformation
        try
            if class of keys is current application's NSURL then
                tell status to setStringValue_(keys)
            else
                tell status to setStringValue_("")
            end if
        end try
    end
    
    on webView_runJavaScriptAlertPanelWithMessage_initiatedByFrame_(sender, message, frame)
        tell current application to display dialog (message as text) buttons {"OK"} with icon 1
    end
    
    on webView_runJavaScriptConfirmPanelWithMessage_initiatedByFrame_(sender, message, frame)
        set userCanceled to false
        try
            tell current application to display dialog (message as text) with icon 1
        on error number -128
            set userCanceled to true
        end try
        if userCanceled then
            return false
        end if
        return true
    end
    
    on webView_runJavaScriptTextInputPanelWithPrompt_defaultText_initiatedByFrame_(sender, prompt, defaultText, frame)
        set userCanceled to false
        try
            tell current application to display dialog (prompt as text) default answer (defaultText as text) with icon 1
            set textReturned to text returned of result
        on error number -128
            set userCanceled to true
        end try
        if userCanceled then
            return
        end if
        return textReturned
    end
    
    on webView_runOpenPanelForFileButtonWithResultListener_allowMultipleFiles_(sender, resultListener, allowMultipleFiles)
        if allowMultipleFiles then
            set fileList to {}
            tell current application to choose file with multiple selections allowed
            repeat with aFile in result
                tell application "Finder" to POSIX path of aFile
                set the end of fileList to result
            end repeat
            tell resultListener to chooseFilenames_(fileList)
        else
            tell current application to choose file
            tell application "Finder" to POSIX path of result
            tell resultListener to chooseFilename_(result)
        end if
    end
    
    -- http://stackoverflow.com/questions/8802537/setting-uidelegate-for-uiwebview
    -- for throw of javascript
    on webView_addMessageToConsole_(sender, message)
        tell message
            set sourceURL to lastPathComponent() of objectForKey_("sourceURL")
            set lineNumber to objectForKey_("lineNumber")
            set messageString to objectForKey_("message")
        end tell
        log "JavaScript console: " & sourceURL & ":" & lineNumber & ": " & messageString
    end
    
    -- http://trac.webkit.org/changeset/75349
    -- http://stackoverflow.com/questions/270458/cocoa-webkit-having-window-open-javascript-links-opening-in-an-instance-of
    -- for window.open()
    on webView_createWebViewWithRequest_(sender, request)
        -- request is null, this is bug.
        -- if you open self webView, return sender
        log "you can't open new window, because request is null. this is bug of WebKit."
        return sender
    end
    
    -- === PolicyDelegate ============================
    
    on webView_decidePolicyForNewWindowAction_request_newFrameName_decisionListener_(sender, windowAction, request, frameName, listener)
        tell sender to setMainFrameURL_(absoluteString of |URL| of request)
        ignore() of listener
    end
    
end script
