//
//  CustomCell.swift
//  IOSSampleApp
//
//  Created by Dima on 09.02.2021.
//

import Foundation
import UIKit
import AdmixerSDK


class CustomCell: UITableViewCell{
    
    @IBOutlet weak var BannerView: UIView!
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
