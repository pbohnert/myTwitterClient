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
    
    class var sharedInstance: TwitterClient {
    struct Static {
        static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecretKey)
        }

   return Static.instance
  }
    
}