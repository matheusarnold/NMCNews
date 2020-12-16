//
//  MyNewsViewController.swift
//  arrayNMCNews
//
//  Created by Laurentia Audrey on 16/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit
import CoreData

var arrMyNews = [PublishedNews]()
class MyNewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableMyNews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableMyNews.dataSource = self
        tableMyNews.delegate = self
        reloadMyNews()
        // Do any additional setup after loading the view.
    }
    
    func reloadMyNews() {
        let defaults = UserDefaults.standard
        let keyAuthor = "\(defaults.integer(forKey: "currUserId"))"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<PublishedNews>(entityName: "PublishedNews")
        fetchReq.predicate = NSPredicate(format: "newsAuthor like %@", keyAuthor)
        do {
            arrMyNews = try context.fetch(fetchReq)
        }
        catch let error {
            print(error.localizedDescription)
        }
        tableMyNews.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMyNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myNewsCell") as! MyNewsTableViewCell
        cell.myNewsCategory.text = arrMyNews[indexPath.row].newsCategory
        cell.myNewsDate.text = arrMyNews[indexPath.row].newsDate
        cell.myNewsTitle.text = arrMyNews[indexPath.row].newsTitle
        cell.myNewsImage.image = UIImage(named: arrMyNews[indexPath.row].newsImage!)
        return cell
    }}
