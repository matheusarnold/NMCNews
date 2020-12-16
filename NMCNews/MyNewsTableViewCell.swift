//
//  MyNewsTableViewCell.swift
//  arrayNMCNews
//
//  Created by Laurentia Audrey on 16/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

class MyNewsTableViewCell: UITableViewCell {
    @IBOutlet weak var myNewsImage: UIImageView!
    @IBOutlet weak var myNewsCategory: UILabel!
    @IBOutlet weak var myNewsTitle: UITextView!
    @IBOutlet weak var myNewsDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
