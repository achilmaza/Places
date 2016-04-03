//
//  PlaceDetailsViewController.swift
//  Places
//
//  Created by Angie Chilmaza on 3/23/16.
//  Copyright © 2016 Angie Chilmaza. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps


class PlaceDetailsViewController: UIViewController, GMSMapViewDelegate{

    var place: Place?
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var placeName: UILabel!
    @IBOutlet var placeRating: UILabel!
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var address: UILabel!
    @IBOutlet var starRating: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        placeName.numberOfLines = 3
        
        if let place = place {
            
            //Set navigation title
            self.navigationItem.title = place.name
            
            //Set place details 
            placeName.text = place.name
            placeRating.text = "\(place.rating)"
            starRating.image = StarRating.rating(place.rating)
            
            if let address = place.address {
                self.address.text = address
            }
            
            
            if (place.photo == nil) {
                let params : [String:AnyObject] = ["maxwidth" : 500,
                                                   "photoreference": "\(place.photoReference)",
                                                   "key" : Constants.Keys.GoogleKey]
                
                Alamofire.request(.GET, Constants.Url.GoogleApiPlaceSearchPhoto, parameters: params ).response{ (request, response, dataIn, error) in
                    
                    
                    //get back to main thread
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        if let imageData = dataIn {
                            self.placeImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }
            else{
                placeImageView.image = place.photo
            }
            
            
            //Display map 
            let coordinates : CLLocationCoordinate2D = CLLocationCoordinate2DMake(place.latitude, place.longitude)
            
            let camera : GMSCameraPosition = GMSCameraPosition(target:coordinates, zoom:15, bearing:0, viewingAngle:0)
            
            self.mapView.camera = camera
            self.mapView.myLocationEnabled = true
            self.mapView.delegate = self;
            
            let marker : GMSMarker = GMSMarker()
            marker.position = coordinates
            marker.title = place.name
            marker.icon =  UIImage(named:"locationPin")
            marker.map = self.mapView;
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //customize navigation bar 
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        let navFont: UIFont = UIFont(name:"Avenir-Heavy", size:19.0)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(), NSFontAttributeName: navFont]
        
    }
    
    
    @IBAction func loadWebsite(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        if let webVC = storyboard.instantiateViewControllerWithIdentifier("WebViewController") as? WebViewController {
            
            if let place = place {
                webVC.name = place.name
                webVC.url = place.website
                self.navigationController?.pushViewController(webVC, animated: true)
            }
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
