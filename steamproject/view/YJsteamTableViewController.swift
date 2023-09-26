//
//  YJsteamTableViewController.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import UIKit

class YJsteamTableViewController: UITableViewController, steamQueryModelProtocol, headerImageQueryModelProtocol, steamUserInfoModelProtocol {
  

    
    
    
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
        
        // 데이터 로드
        steamQueryModels.steamDownloadItems(limit: 25)
        steamUserInfoModel.steamUserInfoItems()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steamFeedItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! YJsteamTableViewCell

        if indexPath.row < steamFeedItem.count && indexPath.row < headerimageFeedItem.count {
            let imageURLString = headerimageFeedItem[indexPath.row].img_link

            if let url = URL(string: imageURLString) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.imgImg_icon_urlView.image = image
                            cell.lblNameView.text = self.steamFeedItem[indexPath.row].name
                        }
                    }
                }
            }
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail" {
            if let cell = sender as? UITableViewCell,
               let indexPath = self.steamListTableView.indexPath(for: cell) {
                FireBaseSteamMessage.img_link = headerimageFeedItem[indexPath.row].img_link
                FireBaseSteamMessage.name = steamFeedItem[indexPath.row].name
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
            self.lblUser.text = "\(personaname) 님의 추천게임"
            print(personaname)
        }
    }
}



    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height

        if contentOffsetY + screenHeight > contentHeight - 100 && !isLoadingData {
            isLoadingData = true
            steamQueryModels.currentPage += 1
            steamQueryModels.steamDownloadItems(limit: 25)
        }
    }
}



