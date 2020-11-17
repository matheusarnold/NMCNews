//
//  AddNewsViewController.swift
//  NMCNews
//
//  Created by Laurentia Audrey on 17/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

class AddNewsViewController: UIViewController {
    @IBAction func btnBack(_ sender: Any) {
        alertMe(message: "Save to draft before leaving?")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
