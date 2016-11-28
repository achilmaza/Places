//
//  PlacesTableViewController.swift
//  Places
//
//  Created by Angie Chilmaza on 3/22/16.
//  Copyright © 2016 Angie Chilmaza. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class PlacesTableViewController: UITableViewController {
    var googlePlaces: [Place]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //customize navigation bar
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 102.0/255.0, green:102.0/255.0, blue:255.0/255.0, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let navFont: UIFont = UIFont(name:"Avenir-Heavy", size:19.0)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: navFont]
        
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.googlePlaces?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> PlaceTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell") as! PlaceTableViewCell

        if let places = googlePlaces {
            var place = places[indexPath.row]
            cell.name?.text = place.name
            cell.rating.text = "\(place.rating)"
            cell.starRating.image = StarRating.rating(place.rating)
            
            
            //Get photo reference
            //Get image in the background and as needed for display.
            //We do not want to get all images at once which could cause performance
            //issues. Plus it's unnecessary. Need to cache the images once they are downloaded
            let photoParams: [String:AnyObject] = ["maxwidth" : 400,
                                                   "photoreference" : "\(place.photoReference)",
                                                   "key": Constants.Keys.GoogleKey]
            
            if(place.photo == nil) {
                Alamofire.request(.GET, Constants.Url.GoogleApiPlaceSearchPhoto, parameters: photoParams).response{
                    (request, response, dataIn, error) in
                    
                    //Get back to main thread
                    //Any changes to UI need to be done in the main thread
                    dispatch_async(dispatch_get_main_queue()) {
                        if let imageData = dataIn {
                        
                            let photo = UIImage(data: imageData)
                            self.googlePlaces?[indexPath.row].photo = photo  //cache image
                            cell.photo.image = photo
                            cell.setNeedsDisplay()
                        }
                    }
                }
                
            }
            else{
                cell.photo.image = place.photo
            }
            
            var locations = [String]();
            locations.append("Hello");
            print(locations);
            
            var locations2:[String] = [];
            locations2.append("Hi");
            print(locations2);
            
            
            
            //Get Icon
            //Get image in the background and as needed for display.
            //We do not want to get all icon images at once which could cause performance
            //issues. Plus it's unnecessary. Need to cache the images once they are downloaded
            
            if(place.icon == nil) {
                Alamofire.request(.GET, place.iconName).response{ (request, response, dataIn, error) in
                    
                    //get back to main thread
                    dispatch_async(dispatch_get_main_queue()) {
                        if let imageData = dataIn {
                            let icon = UIImage(data: imageData)
                            self.googlePlaces?[indexPath.row].icon = icon  //cache image
                            place.icon = icon
                            cell.icon.image = place.icon
                           // cell.layoutIfNeeded()
                           
                        }
                    }
                    
                    
                }
            }
            else{
                
                cell.icon.image = place.icon
            }
            
            
           // Get more details about place using placeid property
            let detailParams: [String:AnyObject] = ["placeid" : place.placeID,
                                                    "key": Constants.Keys.GoogleKey]
            
            Alamofire.request(.GET, Constants.Url.GoogleApiPlaceSearchDetailsJson, parameters: detailParams).responseJSON{
                    
                response in
                
                    if let data = response.data {
                        let json = JSON(data: data)
                        
                        var place = self.googlePlaces?[indexPath.row]
                        PlaceJSONParser.createFromDetails(json, place:&place)
                        
                        self.googlePlaces?[indexPath.row] = place!
                        
                        let priceLevel = place?.priceLevel
                        
                        if(priceLevel >= 4.0){
                            cell.priceLevel.text = "$$$$"
                        }
                        else if (priceLevel >= 3.0){
                            cell.priceLevel.text = "$$$"
                        }
                        else if (priceLevel >= 2.0) {
                            cell.priceLevel.text = "$$"
                        }
                        else if (priceLevel >= 1.0) {
                            cell.priceLevel.text = "$"
                        }
                        else{
                            cell.priceLevel.text = " "
                        }
                        
                    }
            }
            
            
            
        }
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    
        //push to detail view controller
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        if let placeDetailsVC = storyboard.instantiateViewControllerWithIdentifier("PlaceDetailsViewController") as? PlaceDetailsViewController {
            
            if let places = googlePlaces{
                placeDetailsVC.place = places[indexPath.row]
                self.navigationController?.pushViewController(placeDetailsVC, animated: true)
            }
        }
        
    }
    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return .LightContent
//    }

}
