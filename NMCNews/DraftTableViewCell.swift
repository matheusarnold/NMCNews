//
//  DraftTableViewCell.swift
//  arrayNMCNews
//
//  Created by Laurentia Audrey on 16/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

class DraftTableViewCell: UITableViewCell {
    @IBOutlet weak var draftImageView: UIImageView!
    
    @IBOutlet weak var draftDate: UILabel!
    @IBOutlet weak var draftTitle: UITextView!
    @IBOutlet weak var draftCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
