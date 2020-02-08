//
//  ViewController.swift
//  Eko-Test
//
//  Created by ShopMyar on 2/8/20.
//  Copyright © 2020 ShopMyar. All rights reserved.
//

import UIKit
import GithubAPI
import Kingfisher
import RealmSwift
class ViewController: UIViewController {
    
    var usersArray : Results<UserObj>!
    @IBOutlet weak var tblUser: UITableView!
    var userDict : [String : Any]!
    
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
        
        self.getAllUsers(from: "1")
        
        let btnLogout = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(Logout))
        self.navigationItem.rightBarButtonItem = btnLogout
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Test Task"
        
        
    }
    
    @objc func Logout()
    {
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
        }
    }
    func showLoading(isShow : Bool)
    {
        DispatchQueue.main.async {
             if isShow == true
                   {
                    self.activityView.isHidden = false
                    self.activityView.startAnimating()
                   }
                   else
                   {
                    self.activityView.isHidden = true
                    self.activityView.stopAnimating()
                   }
        }
       
    }
    
    
    
    func getAllUsers(from : String)
    {
        self.showLoading(isShow: true)
        let authentication = TokenAuthentication(token: TOKEN)
        UserAPI(authentication: authentication).getAllUsers(since: from) { (response, error) in
            if let response = response {
                print(response)
                
                //let objectRef = ThreadSafeReference(to: UserObj.self)
                // DispatchQueue(label: "background").async {
                
                // }
                DispatchQueue.main.async {
                    let realm = try! Realm()
                    
                    for item in response
                    {
                        var userObj = UserObj()
                        if let login = item.login
                        {
                            userObj.login = login
                        }
                        if let id = item.id
                        {
                            userObj.id = id
                        }
                        if let avatar_url = item.avatarUrl
                        {
                            userObj.avatar_url = avatar_url
                        }
                        if let url = item.url
                        {
                            userObj.url = url
                        }
                        if let type = item.type
                        {
                            userObj.type = type
                        }
                        if let admin = item.siteAdmin
                        {
                            userObj.site_admin = admin
                        }
                        userObj.is_Fav = false
                        try! realm.write
                        {
                            realm.add(userObj)
                        }
                        
                        
                    }
                    
                    
                    self.usersArray = realm.objects(UserObj.self)
                    
                    
                    if self.usersArray.count > 0
                    {
                        self.tblUser.delegate = self
                        self.tblUser.dataSource = self
                        self.tblUser.reloadData()
                    }
                }
                
                
                
                
            } else {
                print(error ?? "")
                self.showAlert(message: error?.localizedDescription ?? "Something Wrong")
                
            }
            self.showLoading(isShow: false)
        }
    }
    
    func showAlert(message : String)
       {
           let alert = UIAlertController(title: "Information", message:message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
    }
    
    @objc func clickFav (sender : UIButton)
    {
        let user = usersArray[sender.tag]
        DispatchQueue.main.async {
            let realm = try! Realm()
            try! realm.write
            {
                if user.is_Fav == false
                {
                    user.is_Fav = true
                }
                else
                {
                    user.is_Fav = false
                }
            }
            self.usersArray = realm.objects(UserObj.self)
            
            
            if self.usersArray.count > 0
            {
                self.tblUser.delegate = self
                self.tblUser.dataSource = self
                self.tblUser.reloadData()
            }
        }
    }
    
    
    
}
extension ViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EkoTableViewCell") as! EkoTableViewCell
        
        let user = self.usersArray[indexPath.row]
        
        cell.imgAvatar.setProfileImage(url: user.avatar_url ?? "", cornerRadius: 50)
        cell.imgAvatar.clipsToBounds = true
        
        cell.lblName.text = user.login
        cell.lblName.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        cell.lblURL.text = user.url
        cell.lblURL.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        cell.lblUserType.text = "User Type : \(user.type!)"
        cell.lblUserType.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        cell.lblSiteAdmin.text = "Site Admin Status : \(user.site_admin)"
        cell.lblSiteAdmin.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        if user.is_Fav == false
        {
            if #available(iOS 13.0, *) {
                cell.btnFav.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            } else {
                // Fallback on earlier versions
            }
        }
        else
        {
            if #available(iOS 13.0, *) {
                cell.btnFav.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                // Fallback on earlier versions
            }
        }
        cell.btnFav.tag = indexPath.row
        cell.btnFav.addTarget(self, action: #selector(self.clickFav(sender:)), for: .touchUpInside)
        
        if indexPath.item == self.usersArray.count - 1
        {
            self.getAllUsers(from: "\(user.id)")
        }
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.usersArray[indexPath.row]
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserInfoViewController") as! UserInfoViewController
        controller.username = user.login!
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
