//
//  loginViewController.swift
//  Eko-Test
//
//  Created by ShopMyar on 2/8/20.
//  Copyright © 2020 ShopMyar. All rights reserved.
//

import UIKit
import GithubAPI
class loginViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        self.setupTextField(txtField: txtPassword, placeholder: "Enter your password")
        self.setupTextField(txtField: txtUserName, placeholder: "Enter your username")
        self.setupButton(title: "Login")
        
    }
    
    
    func setupButton(title : String)
    {
        self.btnLogin.layer.borderWidth = 1
        self.btnLogin.layer.cornerRadius = 5
        self.btnLogin.layer.borderColor = UIColor.black.cgColor
        self.btnLogin.setTitle(title, for: .normal)
    }
    
    func setupTextField (txtField : UITextField , placeholder : String)
    {
        txtField.layer.cornerRadius = 5
        txtField.placeholder = placeholder
        txtField.clipsToBounds = true
        txtField.layer.borderColor = UIColor.black.cgColor
        txtField.layer.borderWidth = 1
        txtField.txtPadding()
        txtField.doneAccessory = true
        
    }
    @IBAction func onClickLogin(_ sender: Any) {
        if txtUserName.text! != "" && txtPassword.text! != ""
        {
            self.getAuth()
        }
        else
        {
            self.showAlert(message:  "Please enter your username and password !")
        }
        
    }
    
    func showAlert(message : String)
    {
        let alert = UIAlertController(title: "Information", message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getAuth()
        {
        
       let authentication = BasicAuthentication(username: "pks1993", password: "Phy03693118672")
        UserAPI(authentication: authentication).getUser { (response, error) in
            if let response = response {
                print(response)
                
                DispatchQueue.main.async {
                    let delegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavViewController") as! UINavigationController
                }
               
            } else {
                print(error ?? "")
                self.showAlert(message: error?.localizedDescription!)
            }
        }
        
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
