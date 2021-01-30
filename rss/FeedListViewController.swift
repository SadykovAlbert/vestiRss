//
//  FeedListViewController.swift
//  rss
//
//  Created by Albert on 25/06/2020.
//  Copyright © 2020 Albert. All rights reserved.
//



import UIKit

class FeedListViewController: UITableViewController, XMLParserDelegate {

    var myFeed : NSArray = []
    var url: URL!
    var nameOfSource: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = nameOfSource
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        tableView.backgroundColor = .darkGray
        self.tableView.dataSource = self
        self.tableView.delegate = self

        loadData()
    }

    @IBAction func refreshFeed(_ sender: Any) {

        loadData()
    }

    func loadData() {
        loadRss(url);
    }

    func loadRss(_ data: URL) {

        let myParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager

        myFeed = myParser.feeds
        tableView.reloadData()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openPage" {
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            let selectedFURL: String = (myFeed[indexPath.row] as AnyObject).object(forKey: "link") as! String

            let fivc: WebViewController = segue.destination as! WebViewController
            fivc.feedURL = selectedFURL as String
        }
    }

    // MARK: - TableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFeed.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0)
        cell.textLabel?.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        let dateText = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "pubDate") as? String
        
        cell.textLabel?.text = cell.textLabel?.text?.replacingOccurrences(of: "\n                    ", with:"")
        cell.textLabel?.text = cell.textLabel?.text?.replacingOccurrences(of: "\n                \n                ", with:"")

        var dT = dateText
        dT?.removeLast(dateText!.count - 22)
        cell.detailTextLabel?.text = dT//?.replacingOccurrences(of: ":00 +0300", with:"")//(of: ":00 +0300\n      ", with:"")
        cell.detailTextLabel?.textColor = UIColor.green

        return cell
    }

}
