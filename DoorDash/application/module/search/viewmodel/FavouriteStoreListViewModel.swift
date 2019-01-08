//
//  FavouriteStoreListViewModel.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 1/5/19.
//  Copyright © 2019 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import Foundation

struct FavouriteStoreListViewModel {
  private var _favoriteStores: [StoreBasicInfo]
  var favoriteStores: [StoreBasicInfo] {
    return _favoriteStores
  }
  
  var count: Int {
    return _favoriteStores.count
  }
  
  init() {
    _favoriteStores = [StoreBasicInfo]()
  }
  
  init(favoriteStores: [StoreBasicInfo]) {
    _favoriteStores = favoriteStores
  }
  
  mutating func addToFavorites(storeInfo: StoreBasicInfo) {
    _favoriteStores.append(storeInfo)
  }
  
  mutating func removeFromFavorites(index: Int) {
    _favoriteStores.remove(at: index)
  }
  
  subscript(storeAt index: Int) -> StoreBasicInfo {
    get {
      return _favoriteStores[index]
    }
    set {
      _favoriteStores[index] = newValue
    }
  }
}
