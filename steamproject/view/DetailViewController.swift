//
//  DetailViewController.swift
//  steamproject
//
//  Created by AHNJAEWON1 on 2023/09/18.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var dimgView: UIImageView!
    
    @IBOutlet weak var appidtest: UILabel!
    
    var imgName = ""
       var appid: String?

       override func viewDidLoad() {
           super.viewDidLoad()

           // 이미지 표시
           let url = URL(string: imgName)

           // appid를 UILabel에 표시
           if let appid = appid {
               appidtest.text = "App ID: " + appid
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
