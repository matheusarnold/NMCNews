//
//  NewsTableViewCell.swift
//  NMCNews
//
//  Created by Laurentia Audrey on 19/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsCategory: UILabel!
    @IBOutlet weak var newsTitle: UITextView!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var imgHolder: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
