//
//  LoginViewController.swift
//  steamproject
//
//  Created by AHNJAEWON1 on 2023/09/18.
//

import UIKit

class LoginViewController: UIViewController {
    
    // 로그인 이미지
    @IBOutlet weak var imgView: UIImageView!
    // 최초 로그인 이미지 변수
    var imageName = "login.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
     let image = UIImage(named: imageName)
        imgView.image = image
    }
    

    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // ViewController
