//
//  ViewControllerInformationWebViewController.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/10/29.
//  Copyright © 2018年 sawatch. All rights reserved.
//

import UIKit
import WebKit

class ViewControllerInformationWeb: UIViewController{

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let webURL = URL(string: "https://fishing-in-kanagawa.com")
        let webRequest = URLRequest(url: webURL!)
        
        webView.load(webRequest)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
