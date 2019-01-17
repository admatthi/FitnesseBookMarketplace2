//
//  OverviewTableViewCell.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/11/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var tapseemore: UIButton!
    @IBOutlet weak var date3: UILabel!
    @IBOutlet weak var name3: UILabel!
    @IBOutlet weak var review3: UILabel!
    @IBOutlet weak var date2: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var review2: UILabel!
    @IBOutlet weak var date1: UILabel!
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var review1: UILabel!
    @IBOutlet weak var reviews: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var mainimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
