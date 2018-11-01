//
//  StoreBasicInfo.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 10/30/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import Foundation

struct StoreBasicInfo {
  let name: String
  let id : Double
  let description: String
  let deliveryFee : Double
  let deliveryTime : Int
  let imageUrl : String
  var isFavorite: Bool
}

extension StoreBasicInfo {
  init?(json: [String: Any]) {
    guard let name = json["name"] as? String,
      let id = json["id"] as? Double,
      let description = json["description"] as? String,
      let deliveryFee = json["delivery_fee"] as? Double,
      let deliveryTime = json["asap_time"] as? Int,
      let imageUrl = json["cover_img_url"] as? String
      else {
        return nil
    }
    
    self.name = name
    self.id = id
    self.description = description
    self.deliveryFee = deliveryFee
    self.deliveryTime = deliveryTime
    self.imageUrl = imageUrl
    self.isFavorite = false
  }
}
