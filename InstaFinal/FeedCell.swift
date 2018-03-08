//
//  FeedCell.swift
//  InstaFinal
//
//  Created by MacBook on 2/26/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var postImage: UIView!
    @IBOutlet weak var postCaption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
