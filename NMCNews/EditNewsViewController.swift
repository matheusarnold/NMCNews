//
//  EditNewsViewController.swift
//  arrayNMCNews
//
//  Created by Laurentia Audrey on 17/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit
import CoreData

class EditNewsViewController: UIViewController {
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color:UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        txtContent.layer.borderWidth = 0.5
        txtContent.layer.borderColor = color.cgColor
        txtContent.layer.cornerRadius = 5.0
    }
    
    @IBAction func btnPublish(_ sender: Any) {
        alertPublish(message: "You can't edit news afterwards!")
    }
    
    @IBAction func btnBack(_ sender: Any) {
        alertMe(message: "Do you want to save news before leaving?")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtTitle.text! = arrDraftDummy[getDraftIndex].draftNewsTitle!
        txtContent.text! = arrDraftDummy[getDraftIndex].draftNewsContent!
    }

    func incrementNewsId() -> Int {
        let defaults = UserDefaults.standard
        let initialId = 1
        var newsId:Int? = defaults.integer(forKey: "newsId")
        if(newsId == nil) {
            defaults.set(initialId, forKey: "newsId")
        }
        else {
            newsId = newsId! + 1
            defaults.set(newsId, forKey: "newsId")
            
        }
        return newsId!
    }
    
    func alertPublish(message:String) -> Void {
        let alertOn = UIAlertController(title: "Publish News?", message: message, preferredStyle: .alert)
        alertOn.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        alertOn.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {action in
            self.publishNews()
            self.performSegue(withIdentifier: "toTVC", sender: self)
        }))
        
        self.present(alertOn, animated: true, completion: nil)
    }
    
    func alertMe(message:String) -> Void {
        let alertOn = UIAlertController(title: "Save to Draft?", message: message, preferredStyle: .alert)
        alertOn.addAction(UIAlertAction(title: "No", style: .destructive, handler: {action in
            self.performSegue(withIdentifier: "backToEditList", sender: self)
        }))
        alertOn.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {action in
            self.saveNewsToDraft()
            self.performSegue(withIdentifier: "backToEditList", sender: self)
        }))
        
        self.present(alertOn, animated: true, completion: nil)
    }

    func alertValidation(message:String) -> Void {
        let alertOn = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alertOn.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertOn, animated: true, completion: nil)
    }
    
    func publishNews() {
        let title = txtTitle.text!
        let content = txtContent.text!
        let newsId = "\(incrementNewsId())"
        if(title == "" || content == "") {
            alertValidation(message: "Please fill all the field")
        }
        else {
            let defaults = UserDefaults.standard
            let keyAuthor = "\(defaults.integer(forKey: "currUserId"))"
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let insDate:String
            
            //get date
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM yyyy"
            insDate = formatter.string(from: date)
            
            let pubNews = PublishedNews(context: context)
            pubNews.newsId = newsId
            pubNews.newsTitle = title
            pubNews.newsCategory = arrDraftDummy[getDraftIndex].draftNewsCategory!
            pubNews.newsContent = content
            pubNews.newsDate = insDate
            pubNews.newsImage = "Lab_Logo"
            pubNews.newsStatus = "published"
            pubNews.newsAuthor = keyAuthor
            
            
            let fetchReq = NSFetchRequest<DraftedNews>(entityName: "DraftedNews")
            fetchReq.predicate = NSPredicate(format: "draftNewsAuthor like %@", keyAuthor)
            do {
                context.insert(pubNews)
                try context.save()
                
                let res = try context.fetch(fetchReq) as [NSManagedObject]
                context.delete(res[getDraftIndex])
                try context.save()
                print("Published")
                
            }
            catch let error {
                print(error.localizedDescription)
            }        }
    }
    
    func saveNewsToDraft() {
        let title = txtTitle.text!
        let content = txtContent.text!
        if(title == "" || content == "") {
            alertValidation(message: "Please fill all the field")
        }
        else {
            let defaults = UserDefaults.standard
            let keyAuthor = "\(defaults.integer(forKey: "currUserId"))"
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let insDate:String
            
            //get date
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM yyyy"
            insDate = formatter.string(from: date)

            let fetchReq = NSFetchRequest<DraftedNews>(entityName: "DraftedNews")
            fetchReq.predicate = NSPredicate(format: "draftNewsAuthor like %@", keyAuthor)
            do {
                let res = try context.fetch(fetchReq) as [NSManagedObject]
                res[getDraftIndex].setValue(keyAuthor, forKey: "draftNewsAuthor")
                res[getDraftIndex].setValue("Lab_Logo", forKey: "draftNewsImage")
                res[getDraftIndex].setValue("drafted", forKey: "draftNewsStatus")
                res[getDraftIndex].setValue("0", forKey: "draftNewsId")
                res[getDraftIndex].setValue(arrDraftDummy[getDraftIndex].draftNewsCategory, forKey: "draftNewsCategory")
                res[getDraftIndex].setValue(content, forKey: "draftNewsContent")
                res[getDraftIndex].setValue(insDate, forKey: "draftNewsDate")
                res[getDraftIndex].setValue(title, forKey: "draftNewsTitle")
                
                try context.save()
                print("Saved to Draft!")
                
            }
            catch let error {
                print(error.localizedDescription)
            }        }
    }
}
