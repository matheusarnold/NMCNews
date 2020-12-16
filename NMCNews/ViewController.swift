//
//  ViewController.swift
//  NMCNews
//
//  Created by Matheus on 16/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit
import CoreData

var currentUserName:String = ""

class ViewController: UIViewController {
    
    
    @IBOutlet weak var LogEmail: UITextField!
    @IBOutlet weak var LogPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = UserDefaults.standard
        checkSettings()
        //clearData()
    }
    
    @IBAction func unwindLoggedOut(_ sender:UIStoryboardSegue) {
        
    }
    
    let noEmail = UIAlertController(title: "All field must be filled", message: "Please input your email", preferredStyle: .alert)
    
    let noPassword = UIAlertController(title: "All field must be filled", message: "Please input your password", preferredStyle: .alert)
    
    let unregistered = UIAlertController(title: "Data not registered", message: "Please sign up first or enter correct email and/or password", preferredStyle: .alert)
    
    let okay = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    
    @IBAction func btnLogin(_ sender: Any) {
        let email = LogEmail.text!
        let password = LogPassword.text!
        
        validateField(email: email, password: password)
    }
    
    func clearData() {
        let defaults = UserDefaults.standard
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchReq = NSFetchRequest<User>(entityName: "User")
        do {
            arrUserDummy = try context.fetch(fetchReq)
        }
        catch let error {
            print(error.localizedDescription)
        }
        let toDelete = arrUserDummy[0]
        do {
            context.delete(toDelete)
            try context.save()
            
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func checkSettings() {
        let defaults = UserDefaults.standard
        let isLogged = defaults.bool(forKey: "isLoggedIn")
        
        defaults.synchronize()
        navigationController?.isNavigationBarHidden = true
        if(isLogged) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let initVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
            appDelegate.window?.rootViewController = initVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    func validateField(email:String, password:String) {
        if (email == ""){
            noEmail.addAction(okay)
            present(noEmail, animated: true, completion: nil)
        }
        else if (password == ""){
            noPassword.addAction(okay)
            present(noPassword, animated: true, completion: nil)
        }
        
        else{
            let isUserExist = validateInDB(txtEmail: email, txtPassword: password)
            if(isUserExist) {
                let defaults = UserDefaults.standard
                defaults.set(currentUserName, forKey: "currUserName")
                defaults.set(true, forKey: "isLoggedIn")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let initVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
                appDelegate.window?.rootViewController = initVC
                appDelegate.window?.makeKeyAndVisible()
            }
            else {
                unregistered.addAction(okay)
                present(unregistered, animated: true, completion: nil)            }
        }
    }
    
    func validateInDB(txtEmail:String, txtPassword:String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchReq = NSFetchRequest<User>(entityName: "User")
        do {
            arrUserDummy = try context.fetch(fetchReq)
        }
        catch let error {
            print(error.localizedDescription)
        }
        for result in arrUserDummy {
            if(txtEmail == result.userEmail && txtPassword == result.userPassword) {
                currentUserName = result.userName!
                let defaults = UserDefaults.standard
                defaults.set(result.userName, forKey: "currUserName")
                defaults.set(result.userId, forKey: "currUserId")
                return true
            }
        }
        
        return false
    }

}


