//
//  AppDelegate.swift
//  TwitterClient
//
//  Created by Peter Bohnert on 10/5/14.
//  Copyright (c) 2014 Blue Lotus Labs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //next two lines are one way to set background color on nav bar.
        let navigationController = application.windows[0].rootViewController as! UINavigationController
        navigationController.navigationBar.barTintColor = UIColor(red: 119/255.0, green: 183/255.0, blue: 238/255.0, alpha: 8/255.0)  //one way to set background color on nav bar.
        
        //next three lines are how to set text color for buttons AND text color for title of all nav bars for all controllers.
        var navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.whiteColor()   // how you set text color for nav bar button items.
        navigationBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()] //set's color for title
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)
        if User.currentUser != nil {
            // go to the logged in screen
            println("current user detected: \(User.currentUser?.name)")
            var vc = storyboard.instantiateViewControllerWithIdentifier("TweetsNavigationController") as! UIViewController
            window?.rootViewController = vc
        }
        return true
    }

    func userDidLogout() {
        var vc = storyboard.instantiateInitialViewController() as! UIViewController
        window?.rootViewController = vc
        
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        TwitterClient.sharedInstance.openURL(url)
        
        return true
        // must add this method in application delegate when calling out to another application URL and returning ... pbohnert 06Oct2014
    }

}

