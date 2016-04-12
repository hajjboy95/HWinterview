//
//  Property.swift
//
//  Created by Ismail El-habbash on 4/8/16.
//  Copyright © 2016 Ismail El-Habbash. All rights reserved.
//

import Foundation
import UIKit


typealias propertyResult = (dic:JSON, error:NSError? ) -> Void
typealias propertyImgResult = (image: UIImage? , error:NSError?) -> Void

let propertyApi = PropertyApi()

enum TypeOfRequest{
    case ListOfProperties , SpecificProperty
}

class PropertyApi {
    
    var session: NSURLSession!
    var task: NSURLSessionDownloadTask!
    let rootUrl = "http://private-anon-65a19f975-practical3.apiary-mock.com"
    
    
    init(){
        
        session = NSURLSession.sharedSession()
        task = NSURLSessionDownloadTask()
    }
    
    
    
    
    
    /**
     Gets the flickr json file from the flickr api and and serializes it into a dictionary for user
     
     - parameter completion: a callback that sends the flkickr info to the controller , callback with params of type NSDictionary , NSError
     */
    func getPropertyData(typeOfRequest:TypeOfRequest , url:String,completion: propertyResult ) {
        
        // Json retured from this is sometimes valid and othertimes invalid
        let urlLink = NSURL(string: rootUrl + url)!
        print(urlLink)
        
        task = session.downloadTaskWithURL(urlLink, completionHandler: { (location:NSURL?, response:NSURLResponse?, error:NSError?) -> Void in
            
            
            if let location = location {
                let data = NSData(contentsOfURL: location)
                
         
                
                do {
                    let dic = try NSJSONSerialization.JSONObjectWithData(data!, options: [.AllowFragments]) as? NSDictionary
                    
                    if let dicVal = dic {
                        var items:AnyObject?
                        if typeOfRequest == .ListOfProperties {
                             items = dicVal["properties"]
                        } else if typeOfRequest == .SpecificProperty {
                            items = dicVal
                        }
                        
                        let swiftyJson = JSON(items!)
                        
                        completion(dic: swiftyJson , error: nil)
                    } else {
                        let error = NSError(domain: "Unablle to parse the json payload", code: 101, userInfo: nil)
                        completion(dic: nil , error: error)

                    }
                 
                    
                    
                } catch  let error as NSError {
                    print("____ \(#line) function = \(#function) file = \(#file)")
                    print("ERROR")
                    completion(dic: nil, error: error)
                    
                }
            }
            else {
                completion(dic: nil, error: nil)
            }
        })
        task.resume()
    }
    
    
    
    /**
     Downloads the image file from the flickr server
     
     - parameter media:      this is the path to the resource
     - parameter completion: a closure which returns a UImage and NSError and both values are optional types.
     */
    func downloadPropertyImage(media:String , completion:propertyImgResult){
        
        let url = NSURL(string:media)
        task = session.downloadTaskWithURL(url!, completionHandler: { (media:NSURL?, response:NSURLResponse?, error:NSError?) -> Void in
            
            if let data = NSData(contentsOfURL: url!) {
                
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                    let img = UIImage(data: data)
                    completion(image: img, error: error)
                    
//                })
            }
        })
        
        task.resume()
    }
    
    
}