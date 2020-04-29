//
//  HomeTableViewCell.swift
//  MobileBlog
//
//  Created by Yasin Shamrat on 30/4/20.
//  Copyright © 2020 Yasin Shamrat. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var body: UILabel!
    @IBOutlet var tags: UILabel!
    @IBOutlet var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
