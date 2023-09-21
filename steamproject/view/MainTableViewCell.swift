//
//  MainTableViewCell.swift
//  steamproject
//
//  Created by AHNJAEWON1 on 2023/09/19.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // 메인화면에 보여줄 게임이미지 View
    @IBOutlet weak var imgView: UIImageView!
    // 메인화면에 보여줄 게임 타이틀 라벨
    @IBOutlet weak var lbltitle: UILabel!
    // 메인화면에 보여줄 게임 가격 라벨
    @IBOutlet weak var lblprice: UILabel!
    
    @IBOutlet weak var lblappid: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
