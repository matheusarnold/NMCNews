//
//  MyDraftViewController.swift
//  arrayNMCNews
//
//  Created by Laurentia Audrey on 16/12/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit
import CoreData

var getDraftIndex:Int = -1

class MyDraftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableDraft: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableDraft.dataSource = self
        tableDraft.delegate = self
        reloadDraft()    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadDraft()
    }
    
    func reloadDraft() {
        let defaults = UserDefaults.standard
        let keyAuthor = "\(defaults.integer(forKey: "currUserId"))"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<DraftedNews>(entityName: "DraftedNews")
        fetchReq.predicate = NSPredicate(format: "draftNewsAuthor like %@", keyAuthor)
        do {
            arrDraftDummy = try context.fetch(fetchReq)
        }
        catch let error {
            print(error.localizedDescription)
        }
        tableDraft.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let draftToDelete = arrDraftDummy[indexPath.row]
            do {
                context.delete(draftToDelete)
                try context.save()
            }
            catch let error {
                print(error.localizedDescription)
            }
            reloadDraft()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getDraftIndex = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDraftDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "draftCell") as! DraftTableViewCell
        cell.draftCategory.text = arrDraftDummy[indexPath.row].draftNewsCategory
        cell.draftDate.text = arrDraftDummy[indexPath.row].draftNewsDate
        cell.draftTitle.text = arrDraftDummy[indexPath.row].draftNewsTitle
        cell.draftImageView.image = UIImage(named: arrDraftDummy[indexPath.row].draftNewsImage!)
        return cell
    }
    
    
}
