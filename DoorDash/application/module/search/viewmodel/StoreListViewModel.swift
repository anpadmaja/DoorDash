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
    return StoreListViewModel(storeInfoList: [])
  }
  
  func fetchStoreList(lat: CLLocationDegrees, long: CLLocationDegrees, success: @escaping (([StoreBasicInfo]) -> Void), failure: @escaping () -> Void) {
    let operation = StoreListOperationsFactory()
    operation.getNearByStoresListOperation(latitude: lat,
                                           longitude: long,
                                           success: { (_,responseObject) in
                                            if let array = responseObject as? [Any] {
                                              var storeInfoList = [StoreBasicInfo]()
                                              for object in array {
                                                guard let storeInfo = StoreBasicInfo(json: object as! [String : Any]) else { continue }
                                                storeInfoList.append(storeInfo)
                                              }
                                              success(storeInfoList)
                                            }
    },
                                           failure: { (_,_) in
                                            failure()
    })
  }

  struct Diff {
    enum StoreListChange: Equatable {
      case inserted(at: [Int])
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
  
  func diffed(with newModel: StoreListViewModel) -> Diff {
    var storeListChange: Diff.StoreListChange?
    
    if newModel.count > storeInfoList.count {
      var indeces = [Int]()
      for (index,storeInfo) in storeInfoList.enumerated() {
        if storeInfo != newModel[at: index] {
          indeces.append(index)
        }
      }
      for i in storeInfoList.count..<newModel.count {
        indeces.append(i)
      }
      
      if indeces.isEmpty {
        storeListChange = nil
      } else {
        storeListChange = .inserted(at: indeces)
      }
    } else if newModel.count == storeInfoList.count-1 {
      storeListChange = .removed(storeInfoList.last!)
    } else if newModel.count == storeInfoList.count {
      var indeces = [Int]()
      for (index,storeInfo) in storeInfoList.enumerated() {
        if storeInfo != newModel[at: index] {
          indeces.append(index)
        }
      }
      
      if indeces.isEmpty {
        storeListChange = nil
      } else {
        storeListChange = .updated(at: indeces)
      }
    } else {
      fatalError("should not reach here")
    }
    
    return Diff(from: self, to: newModel, storeListChange: storeListChange)
  }
}

func ==(lhs: StoreListViewModel, rhs: StoreListViewModel) -> Bool {
  return lhs.storeInfoList == rhs.storeInfoList
}
