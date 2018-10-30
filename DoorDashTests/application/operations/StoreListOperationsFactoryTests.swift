//
//  StoreListOperationsFactoryTests.swift
//  DoorDashTests
//
//  Created by Adhyam Nagarajan, Padmaja on 10/30/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import XCTest
@testable import DoorDash

class StoreListOperationsFactoryTests: XCTestCase {

    func testGetNearByStoresListOperation() {
      let operation = StoreListOperations()
      operation.getNearByStoresListOperation(latitude: 37.585600,
                                             longitude: -122.011151,
                                             success: { (task, responseObject) in
                                              if let array = responseObject as? [Any] {
                                                XCTAssertNotNil(array)
                                              }
      }) { (task, error) in
        XCTAssertNotNil(error)
      }
  }
}
