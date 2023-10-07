//
//  YJsteamTableViewController.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import UIKit
import Firebase
import FirebaseCore

class YJsteamTableViewController: UITableViewController, steamQueryModelProtocol, headerImageQueryModelProtocol, steamUserInfoModelProtocol {
  

    let firebaseInsertModel = FireBaseSteamInsertModel()
    
    
    @IBOutlet var steamListTableView: UITableView!
    
    
    
    @IBOutlet weak var lblUser: UILabel!
    
    

    var steamFeedItem: [steamDBModel] = []
    var headerimageFeedItem: [headerImageDBModel] = []
    var isLoadingData = false // 데이터를 로드 중인지 여부를 나타내는 플래그
    var steamUserInfo: steamUserInfoDBModel?
    
    var steamQueryModels: steamQueryModels!
    var headerImageModel: headerImageQueryModel!
    var steamUserInfoModel: steamUserInfoModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // steamQueryModel, headerImageModel, steamUserInfoModel 객체 초기화 및 delegate 설정
        steamQueryModels = steamproject.steamQueryModels()
        headerImageModel = headerImageQueryModel()
        steamUserInfoModel = steamproject.steamUserInfoModel()
        
        steamQueryModels.delegate = self
        headerImageModel.delegate = self
        steamUserInfoModel.delegate = self
        
        // 데이터를 한 번만 로드하도록 조건문 추가
        if !isLoadingData {
            steamQueryModels.steamDownloadItems(limit: 6)
            steamUserInfoModel.steamUserInfoItems()
            isLoadingData = true
        }
    }

    


    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // steamQueryModel, headerImageModel, steamUserInfoModel 객체 초기화 및 delegate 설정
//        steamQueryModels = steamproject.steamQueryModels()
//        headerImageModel = headerImageQueryModel()
//        steamUserInfoModel = steamproject.steamUserInfoModel()
//
//        steamQueryModels.delegate = self
//        headerImageModel.delegate = self
//        steamUserInfoModel.delegate = self
//
//        // 데이터 로드
//        steamQueryModels.steamDownloadItems(limit: 25)
//        steamUserInfoModel.steamUserInfoItems()
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steamFeedItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! YJsteamTableViewCell

        // headerimageFeedItem 배열의 크기 확인
        if indexPath.row < headerimageFeedItem.count {
            let imageURLString = headerimageFeedItem[indexPath.row].img_link

            // URL을 텍스트로 저장
            if let url = URL(string: imageURLString) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.imgImg_icon_urlView.image = image
                            cell.lblNameView.text = self.headerimageFeedItem[indexPath.row].name
                        }
                    }
                }
            }
            
            // Firebase에 정보 저장
            let imgLink = headerimageFeedItem[indexPath.row].img_link
            let gameName = headerimageFeedItem[indexPath.row].name
            let gamePrice = headerimageFeedItem[indexPath.row].price
            
            // 호출할 Firebase 저장 함수
            let isSuccess = firebaseInsertModel.firebaseSteamInsertItems(img_link: imgLink, name: gameName, price: gamePrice)
            
            if isSuccess {
                print("Data saved to Firebase successfully.")
            } else {
                print("Failed to save data to Firebase.")
            }
        }
        
        return cell
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail" {
            if let cell = sender as? UITableViewCell,
               let indexPath = self.steamListTableView.indexPath(for: cell) {
                FireBaseSteamMessage.img_link = headerimageFeedItem[indexPath.row].img_link
                FireBaseSteamMessage.name = headerimageFeedItem[indexPath.row].name
                FireBaseSteamMessage.price = headerimageFeedItem[indexPath.row].price
            }
        }
    }
    
    

    func steamItemDownloaded(items: [steamDBModel]) {
        steamFeedItem = items
        self.steamListTableView.reloadData()
        isLoadingData = false
    }

    func headerImageDownloaded(items: [headerImageDBModel]) {
        headerimageFeedItem = items
        self.steamListTableView.reloadData()
    }

func steamUserInfoDownloaded(items: [steamUserInfoDBModel]) {
    if let userInfo = items.first, let personaname = userInfo.personaname {
        steamUserInfo = userInfo
        DispatchQueue.main.async {
            self.lblUser.text = "    \(personaname)"
            print(personaname)
        }
    }
}

    


        override func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let contentOffsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let screenHeight = scrollView.frame.size.height
            
            // 데이터 로드 중에는 추가 호출을 방지
            if !isLoadingData && contentOffsetY + screenHeight > contentHeight - 100 {
                isLoadingData = true

            }
        }
}




