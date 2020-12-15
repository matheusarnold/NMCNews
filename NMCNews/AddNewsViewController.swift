//
//  AddNewsViewController.swift
//  NMCNews
//
//  Created by Laurentia Audrey on 17/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

var arrDraftDummy = [NewsItemz]()

class AddNewsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var selected:Int? = -1
    var arrCategory = ["Entertainment", "Politic", "Sport", "Finance", "Automotive"]
    
    @IBOutlet weak var inputitle: UITextField!
    @IBOutlet weak var inputcontent: UITextView!
    
    @IBOutlet weak var pickerCategory: UIPickerView!
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        alertMe(message: "Do you want to save news before leaving?")    }
    
    @IBAction func btnPublish(_ sender: UIBarButtonItem) {
        let insTitle:String
        let insContent:String?
        let insCategory:String?
        let insDate:String?
        
        //get date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        insDate = formatter.string(from: date)
        
        //get the field
        insTitle = inputitle.text!
        insContent = inputcontent.text!
        insCategory = arrCategory[selected!]
        print(insDate)
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
    
    func alertMe(message:String) -> Void {
        let alertOn = UIAlertController(title: "Save to Draft?", message: message, preferredStyle: .alert)
        alertOn.addAction(UIAlertAction(title: "No", style: .destructive, handler: {action in
            self.performSegue(withIdentifier: "backToHome", sender: self)
        }))
        alertOn.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {action in
            self.saveNewsToDraft()
            print("Saved to Draft!")
            self.performSegue(withIdentifier: "backToHome", sender: self)
        }))
        
        self.present(alertOn, animated: true, completion: nil)
    }
    
    func saveNewsToDraft() {
        let insTitle:String
        let insContent:String?
        let insCategory:String?
        let insDate:String?
        
        //get date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        insDate = formatter.string(from: date)
        
        //get the field
        insTitle = inputitle.text!
        insContent = inputcontent.text!
        insCategory = arrCategory[selected!]
        var newsId = "\(arrDraftDummy.count + 1)"
        arrDraftDummy.append(NewsItemz(category: insCategory!, title: insTitle, date: insDate!, content: insContent!, newsId: newsId, img: "Lab_Logo", author: "U0001", status: "drafted"))
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


