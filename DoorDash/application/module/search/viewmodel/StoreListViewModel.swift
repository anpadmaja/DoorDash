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
