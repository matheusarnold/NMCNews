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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let category = arrDummy[0].category
        let title = arrDummy[0].title
        let date = arrDummy[0].date
        let content = arrDummy[0].content
        
        lblKategori.text = category
        lblJudul.text = title
        lblInfo.text = date + "    " + "Saya Surreal"
        txtContent.text = content
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
