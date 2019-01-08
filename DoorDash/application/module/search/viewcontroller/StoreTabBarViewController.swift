//
//  StoreTabBarViewController.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 1/5/19.
//  Copyright © 2019 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import UIKit
import GoogleMaps

class StoreTabBarViewController: UITabBarController {
  
  private let latitude: CLLocationDegrees
  private let longitude: CLLocationDegrees
  
  init(lat: CLLocationDegrees, long: CLLocationDegrees) {
    latitude = lat
    longitude = long
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  lazy var nearByStoresVC : NearByStoreListViewController = {
    let storeVC =  NearByStoreListViewController()
    storeVC.latitude = self.latitude
    storeVC.longitude = self.longitude
    storeVC.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(named: "tab-explore")?.withRenderingMode(.alwaysOriginal), tag: 0)
    return storeVC
  }()
  
  lazy var favoritesVC : FavoritesViewController = {
    let storeVC =  FavoritesViewController()
    storeVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "tab-star")?.withRenderingMode(.alwaysOriginal), tag: 1)
    return storeVC
  }()
  
  lazy var barButtonItem: UIBarButtonItem = {
    let backImage = UIImage(named: "nav-address")
    let a = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    a.setBackgroundImage(backImage, for: .normal, barMetrics: UIBarMetrics.default)
    a.target = self
    a.action = #selector(goBack(_:))
    return a
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewControllers = [nearByStoresVC, favoritesVC]
    configureNavBar()
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
  }
  
  @objc func goBack(_ sender: AnyObject?) {
    self.navigationController?.popViewController(animated: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func configureNavBar() {
    navigationItem.leftBarButtonItem = barButtonItem
    navigationItem.title = "DoorDash"
  }
}
