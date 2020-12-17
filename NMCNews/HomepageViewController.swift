//
//  HomepageViewController.swift
//  NMCNews
//
//  Created by Laurentia Audrey on 17/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit
import CoreData

var arrayDummy = [PublishedNews]()

class HomepageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableViewNews: UITableView!
    
    var receivedName:String?
    
    var receivedTitle:String?
    var receivedContent:String?
    var receivedDate:String?
    var receivedCategory:String?
    var myIndex = 0
    
    @IBAction func unwind(_ sender:UIStoryboardSegue) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewNews.dataSource = self
        tableViewNews.delegate = self
        reloadMyNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadMyNews()
    }
    
    func reloadMyNews() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<PublishedNews>(entityName: "PublishedNews")
        do {
            arrayDummy = try context.fetch(fetchReq)
        }
        catch let error {
            print(error.localizedDescription)
        }
        tableViewNews.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewsTableViewCell
        cell.newsCategory.text = arrayDummy[indexPath.row].newsCategory
        cell.newsTitle.text = arrayDummy[indexPath.row].newsTitle
        cell.newsDate.text = arrayDummy[indexPath.row].newsDate
        cell.imgHolder.image = UIImage(named: arrayDummy[indexPath.row].newsImage!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    //go to detailnews
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let desti = segue.destination as! NewsDetailViewController
            var authorName = ""
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchReq = NSFetchRequest<User>(entityName: "User")
            fetchReq.predicate = NSPredicate(format: "userId like %@", arrayDummy[myIndex].newsAuthor!)
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
            desti.detailTitle = arrayDummy[myIndex].newsTitle
            desti.detailCategory = arrayDummy[myIndex].newsCategory
            desti.detailContent = arrayDummy[myIndex].newsContent
            desti.detailDate = arrayDummy[myIndex].newsDate
            desti.detailAuthor = authorName
            desti.detailInfo = arrayDummy[myIndex].newsImage
            desti.detailAuthorId = arrayDummy[myIndex].newsAuthor
            desti.detailNewsId = arrayDummy[myIndex].newsId
        }
        
    }
    
    
}
