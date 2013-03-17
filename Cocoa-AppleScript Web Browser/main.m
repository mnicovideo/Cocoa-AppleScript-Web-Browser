//
//  main.m
//  Cocoa-AppleScript Web Browser
//
//  Created by tom on 2013/03/17.
//  Copyright (c) 2013年 mii. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, char *argv[])
{
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, (const char **)argv);
}
