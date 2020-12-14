//
//  BookmarkTableViewCell.swift
//  arrayNMCNews
//
//  Created by Laurentia Audrey on 14/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    @IBOutlet weak var bookmarkImgHolder: UIImageView!
    @IBOutlet weak var bookmarkNewsCategory: UILabel!
    @IBOutlet weak var bookmarkNewsTitle: UITextView!
    @IBOutlet weak var bookmarkNewsDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
