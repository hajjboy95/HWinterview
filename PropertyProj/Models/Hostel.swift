//
//  Property.swift
//
//  Created by Ismail El-habbash on 4/8/16.
//  Copyright © 2016 Ismail El-Habbash. All rights reserved.
//

import Foundation


class Hostel {
    
    var city:City
    var hosteId:String?
    var name:String?
    var overallRating:Int?
    var numberOfRatings:Int?
    var type:String?
    var location:Location?
    var images:[Image]
    
    
    init(city:City , hostelId:String? , name:String? , overallRating:Int? , numberOfRatings:Int? , type:String? , location:Location? , images:[Image]){
        self.city = city
        self.hosteId = hostelId
        self.name = name
        self.overallRating = overallRating
        self.numberOfRatings = numberOfRatings
        self.type = type
        self.location = location
        self.images = images
    }
    

    
     var description:String {
        return "city \(self.city) name = \(self.name) type = \(self.type)  images = \(self.images)"
    }
}


class City {
    var cityName:String
    var cityId:Int
    var countryId:Int
    var country:String
    
    init(cityName:String,cityId:Int,countryId:Int,country:String){
        self.cityName = cityName
        self.cityId = cityId
        self.countryId = countryId
        self.country = country
    }
}

class Location {
    var latitude:Float
    var longitude:Float
    
    init (latitude:Float , longitude:Float){
        self.latitude = latitude
        self.longitude = longitude
    }
}

class Image {
    var prefix:String
    var suffix:String
    init(prefix:String,suffix:String){
        self.prefix = prefix
        self.suffix = suffix
    }
    
    func fullUrl() -> String {
        return self.prefix + self.suffix
    }
}

class PropertyDetails:Hostel {
    var propertyDescription:String
    var directions :String
    var address:String
    
    init(city: City, hostelId: String?, name: String?, overallRating: Int?, numberOfRatings: Int?, type: String?, location: Location?, images: [Image] , description:String , directions:String , address:String) {
        
        self.propertyDescription = description
        self.directions = directions
        self.address = address
        
        super.init(city: city, hostelId: hostelId, name: name, overallRating: overallRating, numberOfRatings: numberOfRatings, type: type, location: location, images: images)
        
    }
    
    convenience init(city:City, description:String, directions:String , images:[Image] , address:String){

        self.init(city: city, hostelId: nil, name: nil, overallRating: nil, numberOfRatings: nil, type: nil, location: nil, images: images , description:description , directions:directions , address: address)
    }
    
    override  var description: String {
        return super.description + " propertyDescription = \(self.propertyDescription) directions =  \(self.directions) address = \(self.address)"
    }
    
}
