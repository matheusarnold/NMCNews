//
//  BookmarkViewController.swift
//  arrayNMCNews
//
//  Created by verrell rizky on 14/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit
var arrBookmark = [BookmarkedNews]()
class BookmarkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var bookmarkTableView: UITableView!
    override func viewDidLoad() {
        //print(arrayDummy.count)
        bookmarkTableView.dataSource = self
        bookmarkTableView.delegate = self
        bookmarkTableView.reloadData()
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
