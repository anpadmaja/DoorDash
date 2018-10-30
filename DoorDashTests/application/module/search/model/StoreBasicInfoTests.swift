//
//  StoreBasicInfoTests.swift
//  DoorDashTests
//
//  Created by Adhyam Nagarajan, Padmaja on 10/30/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import XCTest
@testable import DoorDash

class StoreBasicInfoTests: XCTestCase {
  func testFailableInit() {
    let testnil = StoreBasicInfo(json: [:])
    XCTAssert(testnil == nil)
  }
  
  func testStoreBasicInfoModelInit() {
    let testnil = StoreBasicInfo(name: "name", id: 1.0, description: "description", deliveryFee: 2.0, deliveryTime: 20, imageUrl: "https://www.google.com")
    XCTAssert(testnil.name.elementsEqual("name"))
    XCTAssert(testnil.id == 1.0)
    XCTAssert(testnil.description.elementsEqual("description"))
    XCTAssert(testnil.deliveryFee == 2.0)
    XCTAssert(testnil.deliveryTime == 20)
    XCTAssert(testnil.imageUrl.elementsEqual("https://www.google.com"))
  }
  
  func testJsonDeserialization() {
    let json : [String: Any] = ["name" : "name", "id": 1.0, "description": "description", "delivery_fee": 2.0, "asap_time": 20, "cover_img_url": "https://www.google.com"]
    let testnil = StoreBasicInfo(json: json)!
    XCTAssert(testnil.name.elementsEqual("name"))
    XCTAssert(testnil.id == 1.0)
    XCTAssert(testnil.description.elementsEqual("description"))
    XCTAssert(testnil.deliveryFee == 2.0)
    XCTAssert(testnil.deliveryTime == 20)
    XCTAssert(testnil.imageUrl.elementsEqual("https://www.google.com"))
  }
}
