//
//  NearByStoreListViewController.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 10/28/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import UIKit
import AFNetworking

class NearByStoreListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorColor = UIColor.lightGray
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 60
    tableView.register(UINib(nibName: "StoreViewCell", bundle: nil), forCellReuseIdentifier: "StoreViewCell")
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()
  
  private var viewModel: StoreListViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.white
    view.addSubview(tableView)
    configureTableViewConstraints()
    let yourBackImage = UIImage(named: "nav-address")
    
    let a = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    a.setBackgroundImage(yourBackImage, for: .normal, barMetrics: UIBarMetrics.default)
    a.target = self
    a.action = #selector(goBack(_:))
    navigationItem.leftBarButtonItem = a
    
    navigationItem.title = "DoorDash"
    let url = URL(string: "https://api.doordash.com/")!
    let path = "v1/store_search/?lat=37.42274&lng=-122.139956"
    let manager = AFHTTPSessionManager(baseURL: url)
    
    manager.get(path,
                parameters: nil,
                progress: nil,
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
      print("failure")
    }
  }
  
  @objc func goBack(_ sender: AnyObject?) {
    print("going back")
    self.navigationController?.popViewController(animated: true)
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
    print(vm.storeInfoList.count)
    return vm.storeInfoList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreViewCell") as? StoreViewCell else { return UITableViewCell() }
    cell.configureCellData(data: (viewModel?.storeInfoList[indexPath.row])!)
    return cell
  }
}
