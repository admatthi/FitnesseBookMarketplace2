//
//  PostsTableViewCell.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/16/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
