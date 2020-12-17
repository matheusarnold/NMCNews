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
var isRootNewsDeleted = 0
var newsIndexToDelete = ""

class MyNewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var myNewsIndex = -1
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myNewsIndex = indexPath.row
        print("\(myNewsIndex)")
        performSegue(withIdentifier: "toNewsDetail1", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let newsToDelete = arrMyNews[indexPath.row]
            isRootNewsDeleted = 1
            newsIndexToDelete = arrMyNews[indexPath.row].newsId!
            do {
                context.delete(newsToDelete)
                try context.save()
            }
            catch let error {
                print(error.localizedDescription)
            }
            
            reloadMyNews()
        }
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toNewsDetail1") {
            let desti = segue.destination as! NewsDetailViewController
            var authorName = ""
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchReq = NSFetchRequest<User>(entityName: "User")
            fetchReq.predicate = NSPredicate(format: "userId like %@", arrMyNews[myNewsIndex].newsAuthor!)
            do {
                let res = try context.fetch(fetchReq)
                print("size is \(res.count)")
                if(res.count == 0) {
                    authorName = "Admin"
                }
                else {
                    authorName = res[0].userName!
                }
            }
            catch let error {
                print(error.localizedDescription)
            }
            desti.detailTitle = arrMyNews[myNewsIndex].newsTitle
            desti.detailCategory = arrMyNews[myNewsIndex].newsCategory
            desti.detailContent = arrMyNews[myNewsIndex].newsContent
            desti.detailDate = arrMyNews[myNewsIndex].newsDate
            desti.detailAuthor = authorName
            desti.detailInfo = arrMyNews[myNewsIndex].newsImage
            desti.detailAuthorId = arrMyNews[myNewsIndex].newsAuthor
            desti.detailNewsId = arrMyNews[myNewsIndex].newsId        }
    }
    
}
