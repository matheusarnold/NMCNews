//
//  HomepageViewController.swift
//  NMCNews
//
//  Created by Laurentia Audrey on 17/11/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit
/*
struct News {
    var category:String?
    var title:String?
    var date:String?
    var content:String?
}
*/

var arrayDummy = [NewsItemz]()

class HomepageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableViewNews: UITableView!
    
    //var arrDummy = [News]()
    
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
        initial()
        tableViewNews.dataSource = self
        tableViewNews.delegate = self
        tableViewNews.reloadData()
        print(arrayDummy.count)
    }
    
    func initial(){
        //Testing
        //arrDummy.append(News(category: "Entertainment", title: ""))
        arrayDummy.append(NewsItemz(category: "Entertainment", title: "First Day of BTS’ Online Concert Ended with \"We Are Bulletproof: The Eternal\"", date: "10 October 2020", content: "BTS held a two-day online concert \"Map of The Soul ON:E\" on October 10 to 11, as  the result of their postponed world tour \"Map of The Soul Tour\" due to COVID-19 pandemic. Map of the Soul ON:E concert was planned to be held online and offline at the same date, but changed to fully online due to South Korea facing the second wave of the virus. The fans, although disheartened that they can‘t see the boys on stage in person, are still grateful that the concert is not completely absent this year.\nThe concert’s cost is said to be eight times more expensive than their previous online concert \"Bang Bang Con: The Live\" held on July, featuring augmented reality and extended reality technology to enhance the concert’s experience.\nThe first day started off with their most recent full album’s title track \"ON\". The song, the stage set, and the performance giving the fiery and energetic vibe to open the concert, continued by \"N.O\" and \"We Are Bulletproof pt.2\" from their earliest albums.\nThe concert also includes the members’ solo tracks from the Map of The Soul era, starting from RM’s powerful \"Persona\" to J-Hope’s cheerful \"Ego\". The fans are also taken on rollercoaster of emotion when rap line performed fiery \"UGH\" and vocal line performed calming \"00:00\" right after.\nNot only songs from Map of The Soul era, BTS also brings a few tracks from their older days, such as \"Run\", \"Butterfly\", and \"No More Dream\", to reminisce the era with their fans.\nNearing the end of the concert, BTS performed their most recent single \"Dynamite\", as well as talking with their fans during the ending ment, before finally closing the first day with emotional fan song \"We Are Bulletproof: The Eternal\".\nA total of 24 songs were performed in the two-hours concert from 19:00 KST, mixing the songs from their older and newer era.", newsId: "N0001", img: "btsmotsone", author: "U0001"))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewsTableViewCell
        cell.newsCategory.text = arrayDummy[indexPath.row].category
        cell.newsTitle.text = arrayDummy[indexPath.row].title
        cell.newsDate.text = arrayDummy[indexPath.row].date
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
            desti.detailTitle = arrayDummy[myIndex].title
            desti.detailCategory = arrayDummy[myIndex].category
            desti.detailContent = arrayDummy[myIndex].content
            desti.detailDate = arrayDummy[myIndex].date
        }
        
    }
    
    /*
    //get data from addnews
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        let Addpage = unwindSegue.source as! AddNewsViewController
        
        receivedTitle = Addpage.inputitle.text
        receivedContent = Addpage.inputcontent.text
        receivedCategory = Addpage.varcategory
        receivedDate = Addpage.vardate
        
//        if !(receivedTitle == "" || receivedContent == "" || receivedCategory == "" || receivedDate == "") {
            arrDummy.append(News(category: receivedCategory, title: receivedTitle, date: receivedDate, content: receivedContent))
//        }
        tableViewNews.reloadData()
        
    }
    */
}
