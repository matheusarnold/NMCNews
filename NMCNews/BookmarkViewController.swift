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
        bookmarkTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        
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
    
    
    

}
