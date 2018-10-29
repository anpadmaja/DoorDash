//
//  StoreListViewModel.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 10/28/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import Foundation

struct StoreListViewModel {
  let storeInfoList: [StoreBasicInfo]
  
  init?(storeInfoList: [StoreBasicInfo]) {
    guard !storeInfoList.isEmpty else { return nil }
    self.storeInfoList = storeInfoList
  }
}

struct StoreBasicInfo {
  let name: String
  let id : Double
  let description: String
  let delivery_fee : Double
  let deliveryTime : Int
  let imageUrl : String
}

extension StoreBasicInfo {
  init?(json: [String: Any]) {
    guard let name = json["name"] as? String,
      let id = json["id"] as? Double,
      let description = json["description"] as? String,
      let delivery_fee = json["delivery_fee"] as? Double,
      let deliveryTime = json["asap_time"] as? Int,
      let imageUrl = json["cover_img_url"] as? String
      else {
        return nil
      }
    
    self.name = name
    self.id = id
    self.description = description
    self.delivery_fee = delivery_fee
    self.deliveryTime = deliveryTime
    self.imageUrl = imageUrl
  }
}
