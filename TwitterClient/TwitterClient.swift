//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by Peter Bohnert on 10/5/14.
//  Copyright (c) 2014 Blue Lotus Labs. All rights reserved.
//

import UIKit

let twitterConsumerKey = "cXtErwM7XA7QBzSrQmpoGBdkD"
let twitterConsumerSecretKey = "SEM1FyBtlrEWaSoXNSAM4tu02SVFZYL1vBv8J6BTEtWmuggfLa"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

//This class is to define a singleton.  Since Swift doesn't support class
// properties, it will support a computed property.  Nested Structs can have 
// stored properties, so see below.  This shared instance is a type TwitterClient which returns a static instance.

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
    struct Static {
        static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecretKey)
        }

   return Static.instance
  }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        //Fetch request token & redirect to authorization page
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken:BDBOAuthToken!) -> Void in
            println("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL)
            
        }) { (error: NSError!) -> Void in
            println("Failed to get the request token")
            self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken!) -> Void in
            println("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            //call to get current user
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println("user: \(response)")
                var user = User(dictionary: response as NSDictionary)
                println("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("Error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            //call to get home timeline
            TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success:  { (operations: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println("home timeline \(response)")
                var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
                
                for tweet in tweets {
                    println("text: \(tweet.text), created: \(tweet.createdAt)")
                }
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("Error getting home timeline")
            })
            
            }) { (error: NSError!) -> Void in
                println("Failed to receive the access token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
}