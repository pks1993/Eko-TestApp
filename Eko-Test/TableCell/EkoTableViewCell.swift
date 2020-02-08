//
//  EkoTableViewCell.swift
//  Eko-Test
//
//  Created by ShopMyar on 2/8/20.
//  Copyright © 2020 ShopMyar. All rights reserved.
//

import UIKit

class EkoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblURL: UILabel!
    @IBOutlet weak var lblUserType: UILabel!
    @IBOutlet weak var lblSiteAdmin: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
