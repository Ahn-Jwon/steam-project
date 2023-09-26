//
//  OwnViewController.swift
//  steamproject
//
//  Created by TJ on 2023/09/26.
//

import UIKit
import SwiftUI

class OwnViewController: UIViewController {

    @IBOutlet var UserListCollectionView: UICollectionView!
    var dataArray: [UserModel] = []
    var IMGArray: [IMGModel] = []
    let cellMarginSize: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
               let steamQueryModel = steamQueryModel()
      
               steamQueryModel.delegate = self
               steamQueryModel.steamDownloadItems(limit:25)
               UserListCollectionView.delegate = self
               UserListCollectionView.dataSource = self
        
        
}
    // 상세페이지 넘어가는 데이터 코드
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "sgDetail" {
    //            if let cell = sender as? UICollectionViewCell,
    //               let indexPath = self.UserListCollectionView.indexPath(for: cell) {
    //                let detailView = segue.destination as! DetailViewController
    //
    //                detailView.receivedAppId = dataArray[indexPath.row].appid
    //                detailView.receivedName = dataArray[indexPath.row].name
    //                detailView.receivedimgViewPath = dataArray[indexPath.row].img_icon_url
    //                print(detailView.receivedimgViewPath)
    //            }
    //        }
    //    }
         
        }//Controller
        

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */



    extension OwnViewController: UICollectionViewDataSource, UICollectionViewDelegate{
        
        // Cell 갯수
        func collectionView(_ collection: UICollectionView, numberOfItemsInSection section: Int) -> Int{
            return IMGArray.count
        }
        
        // cell 구성
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! OwnCollectionViewCell
            if indexPath.row < IMGArray.count && indexPath.row < dataArray.count {
                let imageURLString = IMGArray[indexPath.row].img_link

                if let url = URL(string: imageURLString) {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.imgView.image = image
                               
                            }
                        }
                    }
                }
            }
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print(IMGArray[indexPath.row])
            
        }
    }


        extension OwnViewController: UICollectionViewDelegateFlowLayout{
           
        // 위아래 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        // 좌우간 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        // Cell Size (옆 라인을 고려하여 설정)
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width / 3 - 1
            let size = CGSize(width: width, height: width)
            return size
        }
            // 섹션에서 콘텐츠를 배치하는 데 사용되는 여백
//            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//                return UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
//            }
        
       
    }

    extension OwnViewController: UserQueryModelProtocol, OwnHeaderImageModelProtocol{
        func GameImageDownloaded(items: [IMGModel]) {
            IMGArray = items
            self.UserListCollectionView.reloadData()
        }
        
        func userItemDownloaded(items: [UserModel]) {
            dataArray = items
            self.UserListCollectionView.reloadData()
        }
        
       
     
        }
        
        
