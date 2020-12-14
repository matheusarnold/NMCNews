//
//  BookmarkViewController.swift
//  arrayNMCNews
//
//  Created by verrell rizky on 14/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var bookmarkTableView: UITableView!
    override func viewDidLoad() {
        print(arrDummy.count)
        bookmarkTableView.dataSource = self
        bookmarkTableView.delegate = self
        bookmarkTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell") as! BookmarkTableViewCell
        cell.bookmarkNewsTitle.text = arrDummy[0].title
        cell.bookmarkNewsDate.text = arrDummy[0].date
        cell.bookmarkNewsCategory.text = arrDummy[0].category
        return cell
    }
    
    
    

}
