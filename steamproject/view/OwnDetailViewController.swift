//
//  OwnDetailViewController.swift
//  steamproject
//
//  Created by TJ on 2023/09/26.
//

import UIKit

class OwnDetailViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblAppid: UILabel!
    
    var appid: Int?
    var gametitle: String?
    var gamePrice: String?
    var imgURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageURLString = imgURL, let url = URL(string: imageURLString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imgView.image = UIImage(data: data)
                    }
                } else {
                    print("Image download failed")
                }
            }
        } else {
            print("Image URL is invalid")
        }
    

   // appid를 UILabel에 표시
//   if let appid = appid {
//       lblAppid.text = "App ID: " + appid
//   }
   
   // appid를 UILabel에 표시
   if let gametitle = gametitle {
       lblTitle.text = gametitle
   }
   
//           // appid를 UILabel에 표시
   if let gamePrice = gamePrice {
       lblPrice.text = gamePrice
   }
        // Do any additional setup after loading the view.
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
