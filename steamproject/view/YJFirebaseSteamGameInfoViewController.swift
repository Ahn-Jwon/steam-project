//
//  YJFirebaseSteamGameInfoViewController.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/10/08.
//

import UIKit

class YJFirebaseSteamGameInfoViewController: UIViewController {

    
    @IBOutlet weak var imgFirebaseStream: UIImageView!
    
    @IBOutlet weak var lblFirebaseStreamName: UILabel!
    
    @IBOutlet weak var lblFirebaseStreamPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        lblFirebaseStreamName.text = "\(FireBaseSteamMessage.name)"
        lblFirebaseStreamPrice.text = "\(FireBaseSteamMessage.price)"
        
        
        if let imageUrl = URL(string: FireBaseSteamMessage.img_link) {
                // Load image data from URL
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            self.imgFirebaseStream.image = image
                        }
                    }
                }.resume()
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
