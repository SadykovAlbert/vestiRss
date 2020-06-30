//
//  FeedWebViewController.swift
//  rss
//
//  Created by Albert on 25/06/2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    var feedURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedURL =  feedURL?.replacingOccurrences(of: " ", with:"")
        feedURL =  feedURL?.replacingOccurrences(of: "\n", with:"")
        webView.load(URLRequest(url: URL(string: feedURL! as String)!))
    }
    
}
