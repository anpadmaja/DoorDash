//
//  StoreListViewModel.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 10/28/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import Foundation
import GoogleMaps

struct StoreListViewModel: Equatable {
  private var _storeInfoList: [StoreBasicInfo]
  
  var storeInfoList: [StoreBasicInfo] {
    return _storeInfoList
  }
  
  init(storeInfoList: [StoreBasicInfo] = [StoreBasicInfo]()) {
    _storeInfoList = storeInfoList
  }
  
  var count: Int {
    return _storeInfoList.count
  }
  
  subscript(at index: Int) -> StoreBasicInfo {
    get {
      return _storeInfoList[index]
    }
    set {
      _storeInfoList[index] = newValue
    }
  }
  
  static var initial: StoreListViewModel {
    let info1 = StoreBasicInfo(name: "Alla", id : 1.0, description: "String", deliveryFee : 10.00, deliveryTime : 1, imageUrl : "www.google.com", isFavorite: false)
    return StoreListViewModel(storeInfoList: [info1])
  }
  
  struct Diff {
    enum StoreListChange: Equatable {
      case inserted(StoreBasicInfo)
      case removed(StoreBasicInfo)
      case updated(at: [Int])
    }
    
    let storeListChange: StoreListChange?
    var from: StoreListViewModel
    var to: StoreListViewModel
    
    fileprivate init(from: StoreListViewModel, to: StoreListViewModel, storeListChange: StoreListChange?) {
      self.storeListChange = storeListChange
      self.from = from
      self.to = to
    }
    
    var hasAnyChanges: Bool {
      return storeListChange != nil
    }
  }
  
  func diffed(with other: StoreListViewModel) -> Diff {
    var storeListChange: Diff.StoreListChange?
    
    if other.count-1 == storeInfoList.count {
      storeListChange = .inserted(other.storeInfoList.last!)
    } else if other.count == storeInfoList.count-1 {
      storeListChange = .removed(storeInfoList.last!)
    } else if other.count == storeInfoList.count {
      var indeces = [Int]()
      for (index,storeInfo) in storeInfoList.enumerated() {
        if storeInfo != other[at: index] {
          indeces.append(index)
        }
      }
      
      if indeces.isEmpty {
        storeListChange = nil
      } else {
        storeListChange = .updated(at: indeces)
      }
    } else {
      fatalError("this case should never happen")
    }
    
    return Diff(from: self, to: other, storeListChange: storeListChange)
  }
}

func ==(lhs: StoreListViewModel, rhs: StoreListViewModel) -> Bool {
  return lhs.storeInfoList == rhs.storeInfoList
}
