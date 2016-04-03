//
//  PlaceJSONParser.swift
//  Places
//
//  Created by Angie Chilmaza on 3/22/16.
//  Copyright © 2016 Angie Chilmaza. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Place {
    var name: String
    var rating: Double
    var latitude: Double
    var longitude: Double
    var iconName: String
    var placeID: String
    var photoReference: String
    var photo: UIImage?
    var icon: UIImage?
    var priceLevel: Double?
    var website: String?
    var phoneNo: String?
    var address: String?
    
   
    //initializer
    init(name: String, rating: Double, latitude: Double, longitude: Double, iconName:String, placeID: String,
        photoReference: String){
            
            self.name = name
            self.rating = rating
            self.latitude = latitude
            self.longitude = longitude
            self.iconName = iconName
            self.placeID = placeID
            self.photoReference = photoReference
    }

}

class PlaceJSONParser: NSObject {
    static func createFrom(incomingJSON: SwiftyJSON.JSON) -> [Place] {
        var resultPlaces: [Place] = []

        let jsonPlaces = incomingJSON["results"].array
        
        for subJSON in jsonPlaces! {
            
            if let name   = subJSON["name"].rawString(),
               let rating = subJSON["rating"].double,
               let location = subJSON["geometry"]["location"].dictionaryObject,
               let icon = subJSON["icon"].rawString(),
               let placeID = subJSON["place_id"].rawString(),
               let photos = subJSON["photos"].arrayObject{
                
                
                if(photos.count > 0){
                    let photoDict:NSDictionary = photos[0] as! NSDictionary
                    
                    
                    if  let photoReference = photoDict["photo_reference"],
                        let latitude  = location["lat"],
                        let longitude = location["lng"]{
                        
                            resultPlaces.append(Place(name:name,
                                rating:rating,
                                latitude:latitude.doubleValue,
                                longitude:longitude.doubleValue,
                                iconName:icon,
                                placeID:placeID,
                                photoReference:photoReference as! String))
                    }
                   
                }
                
            }
            

        }
        
        return resultPlaces
    }
    
    static func createFromDetails(incomingJSON: SwiftyJSON.JSON, inout place:Place?) {
        
        
        let details = incomingJSON["result"].dictionaryObject
        
        if let details = details{
         
            if let website = details["website"]{
                print(website)
                place?.website = website as? String
            }
            
            if let priceLevel = details["price_level"]{
                print(priceLevel)
                place?.priceLevel = priceLevel.doubleValue
            }
            
            if let address = details["formatted_address"]{
                print(address)
                place?.address = address as? String
                
            }
            
            if let addressComponents = details["address_components"]{
                
                print(addressComponents)
                
            }
            
            
        }
        
    
    }

}