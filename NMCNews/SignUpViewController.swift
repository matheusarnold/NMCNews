//
//  SignUpViewController.swift
//  NMCNews
//
//  Created by Laurentia Audrey on 17/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var tf_Name: UITextField!
    @IBOutlet weak var tf_Email: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    @IBOutlet weak var tf_confirmPass: UITextField!
    
    var name:String?
    var email:String?
    var password:String?
    var confirmpass:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btn_signup(_ sender: Any) {
        validate()
    }
    
    
    
    
    
    let name_less3 = UIAlertController(title: "Alert", message: "Name must be more than 3 characters", preferredStyle: .alert)
    
    let emptyFields = UIAlertController(title: "All field must be filled", message: "Please fill all the field to continue", preferredStyle: .alert)
    
    let emailDotcom = UIAlertController(title: "Invalid email", message: "email must be ended with .com", preferredStyle: .alert)
    
    let Confirmpass = UIAlertController(title: "Invalid password", message: "make sure the password you have entered is the same", preferredStyle: .alert)
    
    let passwordLength = UIAlertController(title: "Invalid Password", message: "Password must be more than 8 characters", preferredStyle: .alert)
    
    let SUCCESS = UIAlertController(title: "Success", message: "Sign up success, welcome to NMC News", preferredStyle: .alert)
    
    
    
    let OKAY = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    
    
    func validate()  {
        name = tf_Name.text
        email = tf_Email.text
        password = tf_password.text
        confirmpass = tf_confirmPass.text
        
        if (name == "" || email == "" || password == "" || confirmpass == "") {
            //All field must be filled
            emptyFields.addAction(OKAY)
            present(emptyFields, animated: true, completion: nil)
        }else if (name!.count < 3){
            //name must be more than 3 characters
            name_less3.addAction(OKAY)
            present(name_less3, animated: true, completion: nil)
        }
        
        else if !((email?.hasSuffix(".com"))!){
            //email must be ended with .com
            emailDotcom.addAction(OKAY)
            present(emailDotcom, animated: true, completion: nil)
        }
        
        else if (password!.count < 8){
            //password must be moe than 8
            passwordLength.addAction(OKAY)
            present(passwordLength, animated: true, completion: nil)
        }
        
        else if !(password == confirmpass){
            //make sure password you have entered is the same
            Confirmpass.addAction(OKAY)
            present(Confirmpass, animated: true, completion: nil)
        }
        else{
//            SUCCESS.addAction(OKAY)
//            present(SUCCESS, animated: true, completion: nil)
            performSegue(withIdentifier: "toTabBarController", sender: self)
        }
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
