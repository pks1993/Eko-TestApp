//
//  UserInfoViewController.swift
//  Eko-Test
//
//  Created by ShopMyar on 2/8/20.
//  Copyright © 2020 ShopMyar. All rights reserved.
//

import UIKit
import WebKit
class UserInfoViewController: UIViewController {


   @IBOutlet var userWebview: WKWebView!
    var username = String()
     
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Do any additional setup after loading the view.
        
        activityView.isHidden = false
        activityView.startAnimating()
        self.title = username
        self.userWebview.load(URLRequest(url: URL(string: "\(GIT_URL)\(username)")!))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UserInfoViewController : WKNavigationDelegate
{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityView.isHidden = true
        activityView.stopAnimating()
    }
}
