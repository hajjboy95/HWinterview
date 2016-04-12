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
            
            
            
            
            let cityDic = hostel["city"]
            
            var latitude = hostel["latitude"].floatValue
            var longitude = hostel["longitude"].floatValue
            
            
            
            
            let adId = hostel["id"].string
            let adName = hostel["name"].string
            let type   = hostel["type"].string
            
            let overallRating = hostel["overallRating"]
            let numberOfRating = overallRating["numberOfRatings"].int
            let totalRating = overallRating["overall"].int
        
            var images = parseImages(hostel["images"].array!)
            
            var city = self.parseCity(cityDic)

            var location = Location(latitude: latitude, longitude: longitude)

            
            listOfHostels.append(Hostel(city: city, hostelId: adId!, name: adName!, overallRating: totalRating ?? 0, numberOfRatings: numberOfRating ?? 0, type: type!, location: location, images: images))
            
        }
        
        return listOfHostels
    }
    
     private static func parseImages(hostelImages:[JSON]) -> [Image]{
        var images = [Image]()
        hostelImages.forEach({ (img) in
            let imgSuffix = img["suffix"].stringValue
            let imgPrefix = img["prefix"].stringValue
            let image = Image(prefix: imgPrefix, suffix:imgSuffix)
            images.append(image)
        })

        return images
    }
    
    private static func parseCity(cityDic:JSON) ->City {
        
        
        let country = cityDic["country"].string
        let cityId = Int(cityDic["id"].string!)
        let countryId = Int(cityDic["idCountry"].string!)
        let cityName = cityDic["name"].string
        return City(cityName: cityName!, cityId: cityId!, countryId: countryId!, country: country!)

    }
    
    static func packageSpecificProperty(property:JSON) {
        
        let images = parseImages(property["images"].array ?? [])
        let address1 = property["address1"].string
        let address2 = property["address2"].string
        
        let description = property["description"].string
        let directions  = property["directions"].string
        
        
        
        
    }
    
}