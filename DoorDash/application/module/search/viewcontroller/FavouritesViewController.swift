//
//  FavouritesViewController.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 1/5/19.
//  Copyright © 2019 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import Foundation
import UIKit

class FavoritesViewController: NearByStoreListViewController {
  
  typealias Model = FavouriteStoreListViewModel
  private var favoritesViewModel = FavouriteStoreListViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoritesViewModel.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: storeViewCellReuseIdentifier) as? StoreViewCell else { return UITableViewCell() }
    cell.configureCellData(cellData: favoritesViewModel[storeAt: indexPath.row])
    cell.favorite.isHidden = true
    return cell
  }
}
