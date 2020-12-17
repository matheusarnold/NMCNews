//
//  AddNewsViewController.swift
//  NMCNews
//
//  Created by Laurentia Audrey on 17/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit
import CoreData

var arrCategory = ["Entertainment", "Politic", "Sport", "Finance", "Automotive"]
var arrDraftDummy = [DraftedNews]()
var selected:Int? = -1

class AddNewsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var categoryStackView: UIStackView!
    
    @IBOutlet weak var inputitle: UITextField!
    @IBOutlet weak var inputcontent: UITextView!
    
    @IBOutlet weak var pickerCategory: UIPickerView!
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        alertMe(message: "Do you want to save news before leaving? You can't change category after this!")    }
    
    @IBAction func btnPublish(_ sender: UIBarButtonItem) {
        alertPublish(message: "You can't edit news afterwards!")
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
    
    @IBAction func btnSelectCategory(_ sender: UIButton) {
        pickerCategory.isHidden = false
        selected = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerCategory.isHidden = true
        pickerCategory.dataSource = self
        pickerCategory.delegate = self
        let color:UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        inputcontent.layer.borderWidth = 0.5
        inputcontent.layer.borderColor = color.cgColor
        inputcontent.layer.cornerRadius = 5.0
    }
    
    func alertPublish(message:String) -> Void {
        let alertOn = UIAlertController(title: "Publish News?", message: message, preferredStyle: .alert)
        alertOn.addAction(UIAlertAction(title: "No", style: .destructive, handler: {action in
            self.performSegue(withIdentifier: "backToTabBarHome", sender: self)
        }))
        alertOn.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {action in
            self.publishNews()
            self.performSegue(withIdentifier: "backToTabBarHome", sender: self)
        }))
        
        self.present(alertOn, animated: true, completion: nil)
    }
    
    func alertMe(message:String) -> Void {
        let alertOn = UIAlertController(title: "Save to Draft?", message: message, preferredStyle: .alert)
        alertOn.addAction(UIAlertAction(title: "No", style: .destructive, handler: {action in
            self.performSegue(withIdentifier: "backToTabBarHome", sender: self)
        }))
        alertOn.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {action in
            self.saveNewsToDraft()
            self.performSegue(withIdentifier: "backToTabBarHome", sender: self)
        }))
        
        self.present(alertOn, animated: true, completion: nil)
    }
    
    func alertValidation(message:String) -> Void {
        let alertOn = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alertOn.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertOn, animated: true, completion: nil)
    }
    
    func publishNews() {
        let insTitle:String
        let insContent:String
        let insCategory:String
        let insDate:String
        
        //get date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        insDate = formatter.string(from: date)
        
        //get the field
        insTitle = inputitle.text!
        insContent = inputcontent.text!
        
        
        if(insTitle == "" || insContent == "" || selected == -1) {
            alertValidation(message: "Please fill all the field")
        }
        else {
            insCategory = arrCategory[selected!]
            var newsId = "\(incrementNewsId())"
            let defaults = UserDefaults.standard
            let authorId = "\(defaults.integer(forKey: "currUserId"))"
            let appDelegate = UIApplication.shared.delegate as!AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            print("News #\(newsId)")
            
            let pubNews = PublishedNews(context: context)
            pubNews.newsId = newsId
            pubNews.newsTitle = insTitle
            pubNews.newsCategory = insCategory
            pubNews.newsContent = insContent
            pubNews.newsDate = insDate
            pubNews.newsImage = "Lab_Logo"
            pubNews.newsStatus = "published"
            pubNews.newsAuthor = authorId
            
            do {
                context.insert(pubNews)
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }    }
    
    func saveNewsToDraft() {
        let insTitle:String
        let insContent:String
        let insCategory:String
        let insDate:String
        
        //get date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        insDate = formatter.string(from: date)
        
        //get the field
        insTitle = inputitle.text!
        insContent = inputcontent.text!
        
        
        if(insTitle == "" || insContent == "" || selected == -1) {
            alertValidation(message: "Please fill all the field")
        }
        else {
            insCategory = arrCategory[selected!]
            var newsId = "0"
            let defaults = UserDefaults.standard
            let authorId = "\(defaults.integer(forKey: "currUserId"))"
            let appDelegate = UIApplication.shared.delegate as!AppDelegate
            let context = appDelegate.persistentContainer.viewContext
                
            let draft = DraftedNews(context: context)
            draft.draftNewsId = newsId
            draft.draftNewsTitle = insTitle
            draft.draftNewsCategory = insCategory
            draft.draftNewsContent = insContent
            draft.draftNewsDate = insDate
            draft.draftNewsImage = "Lab_Logo"
            draft.draftNewsStatus = "drafted"
            draft.draftNewsAuthor = authorId
                
            do {
                context.insert(draft)
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrCategory.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrCategory[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
    }


}


