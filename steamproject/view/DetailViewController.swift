//
//  DetailViewController.swift
//  steamproject
//
//  Created by AHNJAEWON1 on 2023/09/18.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var dimgView: UIImageView!
    
    @IBOutlet weak var gametest: UILabel!
    @IBOutlet weak var appidtest: UILabel!
    @IBOutlet weak var gameprice: UILabel!
    
        var imgName = ""
        var appid: String?
        var gametitle: String?
        var gamePrice: String?
        var imgURL: String? // 이미지 URL을 저장하는 변수

       override func viewDidLoad() {
           super.viewDidLoad()

 
           // 이미지 표시
                if let imageURLString = imgURL, let url = URL(string: imageURLString) {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url) {
                            DispatchQueue.main.async {
                                self.dimgView.image = UIImage(data: data)
                            }
                        } else {
                            print("Image download failed")
                        }
                    }
                } else {
                    print("Image URL is invalid")
                }
            

           // appid를 UILabel에 표시
           if let appid = appid {
               appidtest.text = "App ID: " + appid
           }
           
           // appid를 UILabel에 표시
           if let gametitle = gametitle {
               gametest.text = gametitle
           }
           
//           // appid를 UILabel에 표시
           if let gamePrice = gamePrice {
               gameprice.text = gamePrice
           }
       }
   
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
