//
//  UserObj.swift
//  Eko-Test
//
//  Created by ShopMyar on 2/8/20.
//  Copyright © 2020 ShopMyar. All rights reserved.
//

import UIKit
import RealmSwift
import GithubAPI
class UserObj : Object{
    @objc dynamic var login : String?
    dynamic  var id : Int?
    @objc dynamic var avatar_url : String?
    @objc dynamic var url : String?
    @objc dynamic var type : String?
    dynamic var site_admin = false
    @objc dynamic var is_Fav = false
    
    
    
    
}
