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

class StoreListOperations: BaseOperation {
  
  func getNearByStoresListOperation(latitude: CLLocationDegrees,
                                  longitude: CLLocationDegrees,
                                  success: ((URLSessionDataTask, Any?) -> Void)?,
                                  failure: ((URLSessionDataTask, Error) -> Void)?) {
    
    let path = String(format: "v1/store_search/?lat=%1$@&lng=%2$@", String(latitude), String(longitude))
    
    manager.get(path,
                parameters: nil,
                progress: nil,
                success: success)
    { (task, error) in
      NSLog("failure")
    }
  }
}

class BaseOperation {
  
  var manager: AFHTTPSessionManager
  let domainUrl = URL(string: "https://api.doordash.com/") ?? URL(string: "")

  init() {
    manager = AFHTTPSessionManager(baseURL: domainUrl)
  }
}
