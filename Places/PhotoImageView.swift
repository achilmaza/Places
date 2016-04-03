//
//  PhotoImageView.swift
//  Places
//
//  Created by Angie Chilmaza on 3/25/16.
//  Copyright © 2016 Angie Chilmaza. All rights reserved.
//

import UIKit

class PhotoImageView: UIImageView {

   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 2   //round the corner of photo
        self.layer.masksToBounds = true
        self.contentMode = .ScaleAspectFill
    }
    

}
