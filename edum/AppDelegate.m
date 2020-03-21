//
//  AppDelegate.m
//  edum
//
//  Created by Kevin Chan on 26/7/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "AppDelegate.h"
#import "LandingViewController.h"
#import "WeeklyScheduleViewController.h"
#import "MyCoursesViewController.h"
#import "ZhenViewController.h"
#import "LoginViewController.h"

//umeng
#import <UMCommon/UMCommon.h>
#import <UserNotifications/UserNotifications.h>
#import "BTKeychain.h"
#import <WXApi.h>

@interface AppDelegate () <WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [BTKeychain saveUUID];
    [WXApi registerApp:WEIXIN_APP_ID universalLink:UNIVERSAL_LINK];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self ___initTabbars];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)___initTabbars
{
    self.tabbarcontroller = [[UITabBarController alloc] init];
    
    LandingViewController *a = [[LandingViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:a];
    
    WeeklyScheduleViewController *b = [[WeeklyScheduleViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:b];
    
    ZhenViewController *e = [[ZhenViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:e];
    
    self.tabbarcontroller.viewControllers = @[nav1, nav2, nav4];
    
    self.window.rootViewController = self.tabbarcontroller;
    
    [self.window makeKeyAndVisible];
}

- (void)___initLoginview {
    LoginViewController *loginview = [[LoginViewController alloc] init];
    loginview.button_dismiss.hidden = YES;
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginview];
    self.tabbarcontroller = nil;
    self.window.rootViewController = loginview;
    [self.window makeKeyAndVisible];
}

- (void)___presentLoginView:(NSNotification *)noti
{
    [self ___initLoginview];
}

- (void)___dismissLoginView:(NSNotification *)noti
{
    [self ___initTabbars];
}


@end
