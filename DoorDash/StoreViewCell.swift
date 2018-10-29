//
//  StoreViewCell.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 10/28/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import UIKit

class StoreViewCell: UITableViewCell {
  
  @IBOutlet weak var anchorImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var cuisineType: UILabel!
  @IBOutlet weak var stackView: UIStackView!
  
  override func prepareForReuse() {
    titleLabel.text = ""
    cuisineType.text = ""
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func configureCellData(data: StoreBasicInfo) {
    titleLabel.text = data.name
    cuisineType.text = data.description
  }
}
