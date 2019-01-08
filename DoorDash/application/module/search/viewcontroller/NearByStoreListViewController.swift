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

class NearByStoreListViewController: UITableViewController {
  
  private var viewModel = StoreListViewModel.initial

  var latitude: CLLocationDegrees?
  var longitude: CLLocationDegrees?
  
  var storeListDidChange: (([StoreBasicInfo]) -> Void)?
  private var favoritesViewModel = FavouriteStoreListViewModel()
  
  enum Sections: Int {
    case All = 0
    
    var title: String {
      switch self {
      case .All: return "Store List"
      }
    }
    
    static let count = 1
    
    init?(section: Int) {
      self.init(rawValue: section)
    }
    
    init?(indexPath: IndexPath) {
      self.init(rawValue: indexPath.section)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.separatorColor = UIColor.lightGray
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 60
    tableView.register(StoreViewCell.self, forCellReuseIdentifier: storeViewCellReuseIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let lat = self.latitude,
      let long = self.longitude else { return }
    
    let operation = StoreListOperationsFactory()
    operation.getNearByStoresListOperation(latitude: lat,
                                           longitude: long,
                                           success: { (task, responseObject) in
                                            if let array = responseObject as? [Any] {
                                              var storeInfoList = [StoreBasicInfo]()
                                              for object in array {
                                                guard let storeInfo = StoreBasicInfo(json: object as! [String : Any]) else { continue }
                                                storeInfoList.append(storeInfo)
                                              }
                                              self.storeListDidChange?(storeInfoList)
                                            }
    }) { (task, error) in
      NSLog("failure")
    }
  }
  
  func withValues(_ mutations: (inout StoreListViewModel) -> Void) {
    let oldModel = self.viewModel
    
    mutations(&self.viewModel)
    
    /*
     The model and state changes can trigger table view updates so we'll
     wrap both calls in a begin/end updates call to the table view.
     */
    tableView.beginUpdates()
    
    let modelDiff = oldModel.diffed(with: self.viewModel)
    modelDidChange(diff: modelDiff)
    
    tableView.endUpdates()
  }
  
  private func modelDidChange(diff: StoreListViewModel.Diff) {
    if diff.hasAnyChanges {
      guard let change = diff.storeListChange else { return }
      switch change {
      case .inserted:
        let indexPath = IndexPath(row: diff.from.count, section: Sections.All.rawValue)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
      case .updated(let indexes):
        let indexPath = indexes.map({IndexPath(row: $0, section: Sections.All.rawValue)})
        tableView.reloadRows(at: indexPath, with: .automatic)
        
      case .removed:
        let indexPath = IndexPath(row: diff.from.count-1, section: Sections.All.rawValue)
        tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    guard let viewModel = viewModel else { return 0 }
    return viewModel.storeInfoList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let section = Sections(indexPath: indexPath) else { return UITableViewCell() }
    switch section {
    case .All:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: storeViewCellReuseIdentifier) as? StoreViewCell else { return UITableViewCell() }
//      guard let viewModel = viewModel else { return UITableViewCell() }
      cell.configureCellData(cellData: viewModel[at: indexPath.row])
      cell.storeCellDelegate = self
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let section = Sections(section: section) else { return nil }
    return section.title
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let section = Sections(indexPath: indexPath) else { return }
    switch section {
    case .All:
      let detailsVC = StoreDetailsViewController()
      detailsVC.setStoreDetails(store: viewModel[at: indexPath.row])
      navigationController?.pushViewController(detailsVC, animated: true)
    }
    
  }
}

extension NearByStoreListViewController: StoreViewCellDelegate {

  func isMarkedFavorite(cellData: StoreBasicInfo) {
    favoritesViewModel.addToFavorites(storeInfo: cellData)
  }
  
}
