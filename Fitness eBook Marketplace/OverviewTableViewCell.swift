//
//  OverviewTableViewCell.swift
//  Fitness eBook Marketplace
//
//  Created by Alek Matthiessen on 1/11/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
var levels = String()
var minutess = String()
var dayss = String()
var weekss = String()
var goals = String()
var date3s = String()
var name3s = String()
var review3s = String()
var date2s = String()
var name2s = String()
var review2s = String()
var date1s = String()
var name1s = String()
var review1s = String()

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var writereview: UIButton!
    @IBOutlet weak var f: UILabel!
    @IBOutlet weak var e: UILabel!
    @IBOutlet weak var d: UILabel!
    @IBOutlet weak var c: UILabel!
    @IBOutlet weak var b: UILabel!
    @IBOutlet weak var a: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var weeks: UILabel!
    @IBOutlet weak var goal: UILabel!
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
