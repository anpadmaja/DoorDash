//
//  StoreListOperationsFactory.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 10/30/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import Foundation
import GoogleMaps
import AFNetworking

class StoreListOperationsFactory: BaseOperation {
  
  func getNearByStoresListOperation(latitude: CLLocationDegrees,
                                  longitude: CLLocationDegrees,
                                  success: ((URLSessionDataTask, Any?) -> Void)?,
                                  failure: ((URLSessionDataTask, Error) -> Void)?) {
    
    let path = String(format: "v1/store_search/?lat=%1$@&lng=%2$@", String(latitude), String(longitude))
    
    StoreListOperationsFactory.shared().get(path,
                parameters: nil,
                progress: nil,
                success: success)
    {
      (task, error) in
      NSLog("failure")
    }
  }
}

class BaseOperation {
  static let domainUrl = URL(string: "https://api.doordash.com/") ?? URL(string: "")
  
  private static var sharedSessionManager: AFHTTPSessionManager = {
    let networkManager = AFHTTPSessionManager(baseURL: domainUrl)
    return networkManager
  }()
  
  class func shared() -> AFHTTPSessionManager {
    return sharedSessionManager
  }
}
