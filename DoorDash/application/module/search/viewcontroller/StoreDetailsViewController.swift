//
//  StoreDetailsViewController.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 1/7/19.
//  Copyright © 2019 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import Foundation
import UIKit

class StoreDetailsViewController: UIViewController {
  private var _storeDetails: StoreBasicInfo?
  
  func setStoreDetails(store: StoreBasicInfo) {
    self._storeDetails = store
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }
}
