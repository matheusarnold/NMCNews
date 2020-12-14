//
//  ViewController.swift
//  NMCNews
//
//  Created by Matheus on 16/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit
var email:String?
class ViewController: UIViewController {
    
    
    @IBOutlet weak var LogEmail: UITextField!
    @IBOutlet weak var LogPassword: UITextField!
    
    var password:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    let noEmail = UIAlertController(title: "All field must be filled", message: "Please input your email", preferredStyle: .alert)
    
    let noPassword = UIAlertController(title: "All field must be filled", message: "Please input your password", preferredStyle: .alert)
    
    let okay = UIAlertAction(title: "ok", style: .default, handler: nil)
    
    
    @IBAction func btnLogin(_ sender: Any) {
        email = LogEmail.text
        password = LogPassword.text
        
        validate()
    }
    
    func validate() {
        if (email == ""){
            noEmail.addAction(okay)
            present(noEmail, animated: true, completion: nil)
        }
        else if (password == ""){
            noPassword.addAction(okay)
            present(noPassword, animated: true, completion: nil)
        }
        
        else{
            performSegue(withIdentifier: "segueToNews", sender: self)
        }
    }
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destin = segue.destination as! UITabBarController
        let res = destin.viewControllers!.last as! ProfileViewController
        
        res.Myname = email
    }*/
}


