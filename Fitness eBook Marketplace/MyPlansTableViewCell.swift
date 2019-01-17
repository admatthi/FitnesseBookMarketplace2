//
//  MyPlansTableViewCell.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/11/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class MyPlansTableViewCell: UITableViewCell {

    @IBOutlet weak var tapdownload: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var mainimage: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
