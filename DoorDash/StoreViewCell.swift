//
//  StoreViewCell.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 10/28/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import UIKit

class StoreViewCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  override func prepareForReuse() {
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func configureCellData(data: StoreBasicInfo) {
    titleLabel.text = "This is a really long text and it goes on and on and on This is a really long text and it goes on and on and on This is a really long text and it goes on and on and on This is a really long text and it goes on and on and on This is a really long text and it goes on and on and on This is a really long text and it goes on and on and on This is a really long text and it goes on and on and on This is a really long text and it goes on and on and on This is a really long text and it goes on and on and on"
  }
}
