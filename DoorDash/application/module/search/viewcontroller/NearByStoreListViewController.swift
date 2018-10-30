//
//  NearByStoreListViewController.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 10/28/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import UIKit
import AFNetworking
import GoogleMaps

class StoreTabBarViewController: UITabBarController {
  
  var latitude: CLLocationDegrees
  var longitude: CLLocationDegrees

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

class NearByStoreListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  private var viewModel: StoreListViewModel?
  var latitude: CLLocationDegrees?
  var longitude: CLLocationDegrees?
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorColor = UIColor.lightGray
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 60
    tableView.register(StoreViewCell.self, forCellReuseIdentifier: storeViewCellReuseIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.white
    view.addSubview(tableView)
    configureTableViewConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let lat = self.latitude,
      let long = self.longitude else { return }
    
    let operation = StoreListOperations()
    operation.getNearByStoresListOperation(latitude: lat,
                                           longitude: long,
                                           success: { (task, responseObject) in
                                            if let array = responseObject as? [Any] {
                                              var storeInfoList = [StoreBasicInfo]()
                                              for object in array {
                                                guard let storeInfo = StoreBasicInfo(json: object as! [String : Any]) else { continue }
                                                storeInfoList.append(storeInfo)
                                              }
                                              self.viewModel = StoreListViewModel(storeInfoList: storeInfoList)
                                              self.tableView.reloadData()
                                            }
    }) { (task, error) in
      NSLog("failure")
    }
  }

  func configureTableViewConstraints()
  {
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let vm = viewModel else { return 0 }
    return vm.storeInfoList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: storeViewCellReuseIdentifier) as? StoreViewCell, let vm = self.viewModel else { return UITableViewCell() }
    cell.configureCellData(cellData: vm.storeInfoList[indexPath.row])
    return cell
  }
}

class FavoritesViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.brown
  }
}
