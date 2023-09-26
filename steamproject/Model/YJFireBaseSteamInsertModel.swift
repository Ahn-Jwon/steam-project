//
//  YJFireBaseSteamInsertModel.swift
//  steamproject
//
//  Created by leeyoonjae on 2023/09/26.
//

import Foundation

import Firebase

class FireBaseSteamInsertModel{
    let db = Firestore.firestore()
    
    func firebaseSteamInsertItems(img_link: String, name:String, price: String) -> Bool{
        var status: Bool = true
        db.collection("steamUserGameList").addDocument(data: [
            "img_link" : img_link,
                "name" : name,
               "price" : price
        ]){error in
            if error != nil{
                status = false
            }else{
                status = true
            }
            
        }
        return status
    }
}
