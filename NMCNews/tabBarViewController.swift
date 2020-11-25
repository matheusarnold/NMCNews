//
//  tabBarViewController.swift
//  NMCNews
//
//  Created by verrell rizky on 25/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

class tabBarViewController: UITabBarController {
    
    var receivedName:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //kirim data ke sign up
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destin = segue.destination as! ProfileViewController
//
//        if(selectedViewController?.title == "Profile"){
//            destin.name.text = receivedName
//        }
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destin = tabBarController?.viewControllers as! ProfileViewController
//
//        if(tabBarController?.selectedViewController == "Profile")){
//            destin.
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
