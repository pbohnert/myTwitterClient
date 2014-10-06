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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //next two lines are one way to set background color on nav bar.
        let navigationController = application.windows[0].rootViewController as UINavigationController
        navigationController.navigationBar.barTintColor = UIColor(red: 119/255.0, green: 183/255.0, blue: 238/255.0, alpha: 8/255.0)  //one way to set background color on nav bar.
        
        //next three lines are another way to set background color on nav bar AND text color for buttons.
        var navigationBarAppearace = UINavigationBar.appearance()
        //navigationBarAppearace.barTintColor = UIColor.whiteColor()  //another way of setting background color on the nav bar
        navigationBarAppearace.tintColor = UIColor.whiteColor()   // how you set text color for nav bar button items.
        
        //next two lines are how we set text color for nav bar title.
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController.navigationBar.titleTextAttributes = titleDict
        return true
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
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String, annotation: AnyObject?) -> Bool {
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken!) -> Void in
            println("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            //call to get current user
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println("user: \(response)")
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("Error getting current user")
                })
            //call to get home timeline
            TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success:  { (operations: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println("home timeline \(response)")
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("Error getting home timeline")
                })

            }) { (error: NSError!) -> Void in
                println("Failed to receive the access token")
        }
        return true
        // must add this method in application delegate when calling out to another application URL and returning ... pbohnert 06Oct2014
    }

}

