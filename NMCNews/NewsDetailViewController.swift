//
//  NewsDetailViewController.swift
//  NMCNews
//
//  Created by Laurentia Audrey on 19/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    @IBOutlet weak var lblKategori: UILabel!
    @IBOutlet weak var lblJudul: UITextView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var imgViewHolder: UIImageView!
    @IBOutlet weak var txtContent: UITextView!
    
    var detailTitle:String?
    var detailCategory:String?
    var detailContent:String?
    var detailDate:String?
    var detailAuthor:String?
    var detailInfo:String?
    var detailMeta:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
     
    }
    
    func initial(){
        detailMeta = "\(detailDate!) - \(detailAuthor!)"
        lblJudul.text = detailTitle
        txtContent.text = detailContent
        lblInfo.text = detailMeta
        lblKategori.text = detailCategory
        imgViewHolder.image = UIImage(named: detailInfo as! String)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
