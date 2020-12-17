//
//  NewsDetailViewController.swift
//  NMCNews
//
//  Created by Laurentia Audrey on 19/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit
import CoreData

class NewsDetailViewController: UIViewController {
    @IBOutlet weak var lblKategori: UILabel!
    @IBOutlet weak var lblJudul: UITextView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var imgViewHolder: UIImageView!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var btnBM: UIBarButtonItem!
    
    
    var detailTitle:String?
    var detailCategory:String?
    var detailContent:String?
    var detailDate:String?
    var detailAuthor:String?
    var detailInfo:String?
    var detailMeta:String?
    var detailAuthorId:String?
    var detailNewsId:String?
    
    @IBAction func btnAddBookmark(_ sender: UIBarButtonItem) {
        if(btnBM.title == "Add to Bookmark") {
            let defaults = UserDefaults.standard
            let keyUser = "\(defaults.integer(forKey: "currUserId"))"
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let bmNews = BookmarkedNews(context: context)
            bmNews.bookmarkNewsAuthor = detailAuthorId!
            bmNews.bookmarkNewsCategory = detailCategory!
            bmNews.bookmarkNewsContent = detailContent!
            bmNews.bookmarkNewsDate = detailDate!
            bmNews.bookmarkNewsId = detailNewsId!
            bmNews.bookmarkNewsImage = detailInfo!
            bmNews.bookmarkNewsStatus = keyUser
            bmNews.bookmarkNewsTitle = detailTitle!
            do {
                context.insert(bmNews)
                try context.save()
                btnBM.title = "Remove from Bookmark"
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
        else {
            let defaults = UserDefaults.standard
            let keyUser = "\(defaults.integer(forKey: "currUserId"))"
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchReq = NSFetchRequest<BookmarkedNews>(entityName: "BookmarkedNews")
            fetchReq.predicate = NSPredicate(format: "bookmarkNewsId like %@ AND bookmarkNewsStatus like %@", detailNewsId!, keyUser)
            do {
                let res = try context.fetch(fetchReq)
                context.delete(res[0])
                try context.save()
                btnBM.title = "Add to Bookmark"
            }
            catch let error {
                print(error.localizedDescription)
            }        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
        checkBookmarked()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkBookmarked()
    }
    
    func checkBookmarked() {
        let defaults = UserDefaults.standard
        let keyUser = "\(defaults.integer(forKey: "currUserId"))"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<BookmarkedNews>(entityName: "BookmarkedNews")
        fetchReq.predicate = NSPredicate(format: "bookmarkNewsId like %@ AND bookmarkNewsStatus like %@", detailNewsId!, keyUser)
        do {
            let res = try context.fetch(fetchReq)
            for result in res {
                if(result.bookmarkNewsId == detailNewsId && result.bookmarkNewsStatus == keyUser) {
                    btnBM.title = "Remove from Bookmark"
                    break
                }
            }
        }
        catch let error {
            print(error.localizedDescription)
        }    }
    
    func initial(){
        detailMeta = "\(detailDate!) - \(detailAuthor!)"
        lblJudul.text = detailTitle
        txtContent.text = detailContent
        lblInfo.text = detailMeta
        lblKategori.text = detailCategory
        imgViewHolder.image = UIImage(named: detailInfo!)
    }

}
