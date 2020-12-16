//
//  SignUpViewController.swift
//  NMCNews
//
//  Created by Laurentia Audrey on 17/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

var arrUserDummy = [User]()

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
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destin = segue.destination as! UITabBarController
        let res = destin.viewControllers!.last as! ProfileViewController
        
        res.Myname = name
    }
    */
    
    func incrementUserId() -> Int {
        let defaults = UserDefaults.standard
        let initialId = 1
        var userId:Int? = defaults.integer(forKey: "userId")
        if(userId == nil) {
            defaults.set(initialId, forKey: "userId")
        }
        else {
            userId = userId! + 1
            defaults.set(userId, forKey: "userId")
            
            //reset bc have not entered db
            //defaults.set(nil, forKey: "userId")
            
        }
        return userId!
    }
        
    let name_less3 = UIAlertController(title: "Alert", message: "Name must be more than 3 characters", preferredStyle: .alert)
    
    let emptyFields = UIAlertController(title: "All field must be filled", message: "Please fill all the field to continue", preferredStyle: .alert)
    
    let emailDotcom = UIAlertController(title: "Invalid email", message: "email must be ended with .com", preferredStyle: .alert)
    
    let noET = UIAlertController(title: "Invalid email", message: "email must contains @", preferredStyle: .alert)
    
    let EtDot = UIAlertController(title: "Invalid email", message: "email can't have @.", preferredStyle: .alert)
    
    let Confirmpass = UIAlertController(title: "Invalid password", message: "make sure the password you have entered is the same", preferredStyle: .alert)
    
    let passwordLength = UIAlertController(title: "Invalid Password", message: "Password must be more than 8 characters", preferredStyle: .alert)
    
    let SUCCESS = UIAlertController(title: "Success", message: "Sign up success, welcome to NMC News", preferredStyle: .alert)
    
    
    
    let OKAY = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    
    
    func validate()  {
        name = tf_Name.text
        email = tf_Email.text
        password = tf_password.text
        confirmpass = tf_confirmPass.text
        let userId = "\(incrementUserId())"
        if (name == "" || email == "" || password == "" || confirmpass == "") {
            //All field must be filled
            emptyFields.addAction(OKAY)
            present(emptyFields, animated: true, completion: nil)
        }
        else if (name!.count < 3){
            //name must be more than 3 characters
            name_less3.addAction(OKAY)
            present(name_less3, animated: true, completion: nil)
        }
        else if !((email?.contains("@"))!){
            //email must contains @
            noET.addAction(OKAY)
            present(noET, animated: true, completion: nil)
        }
        else if (email!.contains("@.")){
            EtDot.addAction(OKAY)
            present(EtDot, animated: true, completion: nil)
        }
        else if !((email?.hasSuffix(".com"))!){
            //email must be ended with .comm
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
            //arrUserDummy.append(UserTemplate(userName: name!, userEmail: email!, userPassword: password!, userId: userId))
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let user = User(context: context)
            user.userId = userId
            user.userName = name!
            user.userEmail = email!
            user.userPassword = password!
            
            context.insert(user)
            do {
                try context.save()
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "isLoggedIn")
                defaults.set(name!, forKey: "currUserName")
                defaults.set(userId, forKey: "currUserId")
            }
            catch let error {
                print(error.localizedDescription)
            }
            
            performSegue(withIdentifier: "toTabBarController", sender: self)
        }
    }
    //Test

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
