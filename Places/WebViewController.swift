//
//  WebViewController.swift
//  Places
//
//  Created by Angie Chilmaza on 3/25/16.
//  Copyright © 2016 Angie Chilmaza. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    var url: String?
    var name: String?
    @IBOutlet var webView: UIWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = name
        let urlLink:NSURL = NSURL(string: url!)!
        self.webView.loadRequest(NSURLRequest(URL: urlLink))
        self.webView.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
