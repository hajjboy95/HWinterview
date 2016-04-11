//
//  Property.swift
//
//  Created by Ismail El-habbash on 4/8/16.
//  Copyright © 2016 Ismail El-Habbash. All rights reserved.
//

import Foundation


struct Hostel {
    
    var city:City
    var hosteId:String
    var name:String
    var overallRating:Int
    var numberOfRatings:Int
    var type:String
    var location:Location
    var images:[Image]
    
}


struct City {
    var cityName:String
    var cityId:Int
    var countryId:Int
    var country:String
}

struct Location {
    var latitude:Float
    var longitude:Float
}

struct Image {
    var prefix:String
    var suffix:String
}
