//
//  PlaceTableViewCell.swift
//  Places
//
//  Created by Angie Chilmaza on 3/22/16.
//  Copyright © 2016 Angie Chilmaza. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    
    @IBOutlet var icon: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var photo: UIImageView!
    @IBOutlet var priceLevel: UILabel!
    @IBOutlet var starRating: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//      photo.layer.cornerRadius = 2   //round the corner of photo 
        photo.layer.masksToBounds = true
        photo.contentMode = .ScaleAspectFill
    }
  

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
