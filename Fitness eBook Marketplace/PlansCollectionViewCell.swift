//
//  PlansCollectionViewCell.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/11/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class PlansCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var authorname: UILabel!
    @IBOutlet weak var reviewcount: UILabel!
    @IBOutlet weak var newprice: UILabel!
    @IBOutlet weak var oldprice: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var plancover: UIImageView!
    
    @IBOutlet weak var tapdownload: UIButton!
    @IBOutlet weak var dark: UIImageView!
    @IBOutlet weak var reviewsimgae: UIImageView!
}
