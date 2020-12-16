//
//  ProfileViewController.swift
//  NMCNews
//
//  Created by verrell rizky on 25/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController{
   
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBAction func btnLogout(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "isLoggedIn")
        defaults.synchronize()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let initVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
        appDelegate.window?.rootViewController = initVC
        appDelegate.window?.makeKeyAndVisible()
        
    }
    
    @IBAction func unwindToProfile (_ sender: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        let defaults = UserDefaults.standard
        let currName = defaults.string(forKey: "currUserName")
        name.text = "Hello, \(currName!)"
    }
    
}
