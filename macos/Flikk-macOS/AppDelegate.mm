#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>

@implementation AppDelegate

- (id)init {
  if (self = [super init]) {
    NSScreen *screen = NSScreen.mainScreen;

    int preferredWidth = 1200;
    int preferredHeight = 800;

    NSRect contentSize = NSMakeRect(
        screen.visibleFrame.origin.x + screen.visibleFrame.size.width / 2 -
            CGFloat(preferredWidth) / 2,
        screen.visibleFrame.origin.y + screen.visibleFrame.size.height / 2 -
            CGFloat(preferredHeight) / 2,
        CGFloat(preferredWidth), CGFloat(preferredHeight));

    self.window = [[NSWindow alloc]
        initWithContentRect:contentSize
                  styleMask:NSWindowStyleMaskTitled |
                            NSWindowStyleMaskResizable |
                            NSWindowStyleMaskFullSizeContentView |
                            NSWindowStyleMaskMiniaturizable |
                            NSWindowStyleMaskClosable
                    backing:NSBackingStoreBuffered
                      defer:NO];

    NSWindowController *windowController =
        [[NSWindowController alloc] initWithWindow:self.window];

    [[self window] setTitleVisibility:NSWindowTitleVisible];
    [[self window] setTitlebarAppearsTransparent:YES];

    [windowController setShouldCascadeWindows:YES];
    [windowController showWindow:self.window];

    NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"mainToolbar"];

    [self.window setToolbar:toolbar];
  }

  return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
  NSURL *jsCodeLocation;

  jsCodeLocation = [self sourceURLForBridge:self.bridge];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"flikk"
                                               initialProperties:nil
                                                   launchOptions:nil];

  [self.window setContentView:rootView];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {
#if DEBUG
  return
      [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main"
                                 withExtension:@"jsbundle"];
#endif
}

- (BOOL)concurrentRootEnabled {
#ifdef RN_FABRIC_ENABLED
  return true;
#else
  return false;
#endif
}

@end
