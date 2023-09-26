//
//  YJFireBaseSteamQueryModelProtocol.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import Foundation

import Firebase
import FirebaseCore

protocol FireBaseSteamQueryModelProtocol{
    func steamItemDowmLoaded(items: [FireBaseSteamDBModel])
}

class firebaseSteamQueryModel{
    var delegate: FireBaseSteamQueryModelProtocol!
    let db = Firestore.firestore()
    
    func firebaseDowmloadItems(){
        var locations: [FireBaseSteamDBModel] = []
        db.collection("steamUserGameList").order(by: "name").getDocuments(completion: {(querySnapshot, err) in
            if err != nil{
                print("정보를 가져오는 중 오류 발생")
            }else{
                print("데이터가 다운로드 되었습니다.")
                
                for document in querySnapshot!.documents{
                    guard let data = document.data()["name"] else {return}
                    print("\(document.documentID)  => \(data)")
                    
                    let query = FireBaseSteamDBModel(img_link: document.data()["img_link"] as! String, name: document.data()["name"] as! String, price: document.data()["price"] as! String)
                    locations.append(query)
                }
                DispatchQueue.main.async {
                    self.delegate.steamItemDowmLoaded(items: locations)
                }
            }
        })
    }
}
