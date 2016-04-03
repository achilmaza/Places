//
//  Constants.swift
//  Places
//
//  Created by Angie Chilmaza on 3/25/16.
//  Copyright © 2016 Angie Chilmaza. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    struct Keys {
        
        static let GoogleKey = "place google api key here"
    }
    
    struct Url {
        static let GoogleApiPlaceSearchJson = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        static let GoogleApiPlaceSearchPhoto = "https://maps.googleapis.com/maps/api/place/photo"
        static let GoogleApiPlaceSearchDetailsJson = "https://maps.googleapis.com/maps/api/place/details/json"
    }

}
