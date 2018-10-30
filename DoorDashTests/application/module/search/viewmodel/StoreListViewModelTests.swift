//
//  StoreListViewModelTests.swift
//  DoorDashTests
//
//  Created by Adhyam Nagarajan, Padmaja on 10/30/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import XCTest
@testable import DoorDash

class StoreListViewModelTests: XCTestCase {
  
  var storeInfo1 = StoreBasicInfo(name: "name", id: 1.0, description: "description", deliveryFee: 2.0, deliveryTime: 20, imageUrl: "https://www.google.com")
  var storeInfo2 = StoreBasicInfo(name: "name2", id: 2.0, description: "description2", deliveryFee: 2.0, deliveryTime: 20, imageUrl: "https://www.google.com")
  
  func testViewModelInit() {
    let storeList = [storeInfo1, storeInfo2]
    let vm = StoreListViewModel(storeInfoList: storeList)
    XCTAssert(vm?.storeInfoList.count == 2)
    XCTAssert(vm!.storeInfoList[0].name.elementsEqual("name"))
    XCTAssert(vm!.storeInfoList[1].name.elementsEqual("name2"))
  }
  
  func testNullableVMInit() {
    let vm = StoreListViewModel(storeInfoList: [])
    XCTAssertNil(vm)
  }
}
