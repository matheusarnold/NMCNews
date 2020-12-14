//
//  AddNewsViewController.swift
//  NMCNews
//
//  Created by Laurentia Audrey on 17/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit


    var arrDummy = [News]()



class AddNewsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var vartitle:String?
    var varcontent:String?
    var varcategory:String?
    var vardate:String?
    
    
    var arrCategory = ["Entertainment", "Politic", "Sport", "Finance", "Automotive"]
    
    
    @IBOutlet weak var inputitle: UITextField!
    @IBOutlet weak var inputcontent: UITextView!
    
    
    
    
    @IBOutlet weak var pickerCategory: UIPickerView!
    @IBAction func btnBack(_ sender: Any) {
        alertMe(message: "Save to draft before leaving?")
    }
    
    //data yg dari inputitle & inputcontent gabisa masuk, why
    func getTF(){
        vartitle = inputitle.text!
        varcontent = inputcontent.text!
        varcategory = "contoh category"
        vardate = "contohdate"
    }
    
    
    @IBAction func btnSelectCategory(_ sender: UIButton) {
        pickerCategory.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerCategory.isHidden = true
        pickerCategory.dataSource = self
        pickerCategory.delegate = self
        
        getTF()
    }
    
    func alertMe(message:String) -> Void {
        let alertOn = UIAlertController(title: "Save to Draft", message: message, preferredStyle: .alert)
        alertOn.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: {action in
            self.performSegue(withIdentifier: "segueBackFromAddNews", sender: self)
        }))
        alertOn.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {action in
            //save data here
            self.notificationAlert(message: "Data saved to draft!")
        }))
        self.present(alertOn, animated: true, completion: nil)
    }
    
    func notificationAlert(message:String) -> Void {
        let alertOn = UIAlertController(title: "Save Success", message: message, preferredStyle: .alert)
        alertOn.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {action in
            self.performSegue(withIdentifier: "segueBackFromAddNews", sender: self)
        }))
        self.present(alertOn, animated: true, completion: nil)
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
    
    
    

}


