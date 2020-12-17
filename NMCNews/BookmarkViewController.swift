//
//  BookmarkViewController.swift
//  arrayNMCNews
//
//  Created by verrell rizky on 14/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit
import CoreData

var arrBookmark = [BookmarkedNews]()

class BookmarkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var index = -1
    
    @IBOutlet weak var bookmarkTableView: UITableView!
    override func viewDidLoad() {
        bookmarkTableView.dataSource = self
        bookmarkTableView.delegate = self
        deleteIfRootNewsDeleted()
        bookmarkTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        deleteIfRootNewsDeleted()
        reloadBookmark()
    }
    
    func reloadBookmark() {
        let defaults = UserDefaults.standard
        let keyUser = "\(defaults.integer(forKey: "currUserId"))"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<BookmarkedNews>(entityName: "BookmarkedNews")
        fetchReq.predicate = NSPredicate(format: "bookmarkNewsStatus like %@", keyUser)
        do {
            arrBookmark = try context.fetch(fetchReq)
        }
        catch let error {
            print(error.localizedDescription)
        }
        bookmarkTableView.reloadData()
    }
    
    func deleteIfRootNewsDeleted() {
        let defaults = UserDefaults.standard
        let keyAuthor = "\(defaults.integer(forKey: "currUserId"))"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<BookmarkedNews>(entityName: "BookmarkedNews")
        fetchReq.predicate = NSPredicate(format: "bookmarkNewsId like %@ AND bookmarkNewsAuthor like %@", newsIndexToDelete, keyAuthor)
        do {
            let res = try context.fetch(fetchReq)
            for result in res {
                context.delete(result)
                try context.save()
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
        bookmarkTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let bookmarkToDelete = arrBookmark[indexPath.row]
            do {
                context.delete(bookmarkToDelete)
                try context.save()
            }
            catch let error {
                print(error.localizedDescription)
            }
            reloadBookmark()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "toNewsDetail3", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBookmark.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell") as! BookmarkTableViewCell
        cell.bookmarkNewsTitle.text = arrBookmark[indexPath.row].bookmarkNewsTitle
        cell.bookmarkNewsDate.text = arrBookmark[indexPath.row].bookmarkNewsDate
        cell.bookmarkNewsCategory.text = arrBookmark[indexPath.row].bookmarkNewsCategory
        cell.bookmarkImgHolder.image = UIImage(named: arrBookmark[indexPath.row].bookmarkNewsImage!)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toNewsDetail3") {
            let desti = segue.destination as! NewsDetailViewController
            var authorName = ""
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchReq = NSFetchRequest<User>(entityName: "User")
            fetchReq.predicate = NSPredicate(format: "userId like %@", arrBookmark[index].bookmarkNewsStatus!)
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
            desti.detailAuthor = authorName
            desti.detailAuthorId = arrBookmark[index].bookmarkNewsAuthor
            desti.detailCategory = arrBookmark[index].bookmarkNewsCategory
            desti.detailContent = arrBookmark[index].bookmarkNewsContent
            desti.detailDate = arrBookmark[index].bookmarkNewsDate
            desti.detailInfo = arrBookmark[index].bookmarkNewsImage
            desti.detailNewsId = arrBookmark[index].bookmarkNewsId
            desti.detailTitle = arrBookmark[index].bookmarkNewsTitle
        }
    }
    

}
