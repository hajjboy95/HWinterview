//
//  JsonParser.swift
//  CommunicateWithBackend
//
//  Created by Ismail El-habbash on 4/11/16.
//  Copyright © 2016 Ismail El-Habbash. All rights reserved.
//

import Foundation
class JsonParser {
    
    
    
    
    
    static func packageHostel(hostels:JSON) -> [Hostel]{

        var listOfHostels = [Hostel]()

        
        hostels.forEach { (id,hostel) in
            print("==================================")
//            print(hostel)
            
            
            let cityDic = hostel["city"]
            
            
            let country = cityDic["country"].string
            let cityId = Int(cityDic["id"].string!)
            let countryId = Int(cityDic["idCountry"].string!)
            let cityName = cityDic["name"].string
           
            
            var latitude = hostel["latitude"].floatValue
            var longitude = hostel["longitude"].floatValue
            
            
            
            
            let adId = hostel["id"].string
            let adName = hostel["name"].string
            let type   = hostel["type"].string
            
            let overallRating = hostel["overallRating"]
            let numberOfRating = overallRating["numberOfRatings"].int
            let totalRating = overallRating["overall"].int
            

            print("numberOfRating = \(numberOfRating)")
            print("TotalRating = \(totalRating)")
            var images = [Image]()
            hostel["images"].array?.forEach({ (img) in
//                print(img)
                let imgSuffix = img["suffix"].stringValue
                let imgPrefix = img["prefix"].stringValue
                var image = Image(prefix: imgPrefix, suffix:imgSuffix)
                images.append(image)
            })

            
            var city = City(cityName: cityName!, cityId: cityId!, countryId: countryId!, country: country!)

            var location = Location(latitude: latitude, longitude: longitude)

            
            listOfHostels.append(Hostel(city: city, hosteId: adId!, name: adName!, overallRating: totalRating ?? 0, numberOfRatings: numberOfRating ?? 0, type: type!, location: location, images: images))
            
        }
        
        return listOfHostels
    }
    
    
}