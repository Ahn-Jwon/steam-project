//
//  YJsteamTableViewCell.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import UIKit

class YJsteamTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgImg_icon_urlView: UIImageView!
    
    @IBOutlet weak var lblNameView: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
