//
//  StoreViewCell.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 10/28/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import UIKit

let storeViewCellReuseIdentifier = "StoreViewCell"

class StoreViewCell: UITableViewCell {
  
  let genericAnchorConstraints: CGFloat = 12
  
  lazy var card: UIView = {
    let a = UIView()
    a.translatesAutoresizingMaskIntoConstraints = false
    a.backgroundColor = UIColor.white
    return a
  }()
  
  lazy var verticalStackView: UIStackView = {
    let stackview = UIStackView()
    stackview.translatesAutoresizingMaskIntoConstraints = false
    stackview.axis = .vertical
    return stackview
  }()
  
  lazy var storeImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  lazy var stackView: UIStackView = {
    let stackview = UIStackView()
    stackview.translatesAutoresizingMaskIntoConstraints = false
    stackview.axis = .horizontal
    stackview.alignment = .fill
    stackview.distribution = .fillProportionally
    stackview.spacing = 20
    stackview.isUserInteractionEnabled = false
    return stackview
  }()
  
  lazy var storeName: UILabel = {
    let a = UILabel()
    a.translatesAutoresizingMaskIntoConstraints = false
    a.textColor = UIColor.black
    a.textAlignment = .natural
    a.numberOfLines = 0
    a.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
    return a
  }()
  
  lazy var cuisineType: UILabel = {
    let a = UILabel()
    a.translatesAutoresizingMaskIntoConstraints = false
    a.textColor = UIColor.lightGray
    a.textAlignment = .natural
    a.numberOfLines = 0
    a.font = UIFont(name:"HelveticaNeue", size: 14.0)
    return a
  }()
  
  lazy var deliveryFee: UILabel = {
    let a = UILabel()
    a.translatesAutoresizingMaskIntoConstraints = false
    a.textColor = UIColor.black
    a.textAlignment = .natural
    a.numberOfLines = 1
    a.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
    a.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
    a.lineBreakMode = .byTruncatingTail
    a.font = UIFont(name:"HelveticaNeue", size: 14.0)
    return a
  }()
  
  lazy var deliveryTime: UILabel = {
    let a = UILabel()
    a.translatesAutoresizingMaskIntoConstraints = false
    a.textColor = UIColor.black
    a.textAlignment = .natural
    a.numberOfLines = 1
    a.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
    a.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
    a.lineBreakMode = .byTruncatingTail
    return a
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: storeViewCellReuseIdentifier)
    selectionStyle = .none
    initializeLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    storeName.text = ""
    deliveryTime.text = ""
    deliveryFee.text = ""
    cuisineType.text = ""
  }
  
  private func setAccessibility() {
    subviews.forEach { $0.isAccessibilityElement = false }
    isAccessibilityElement = true
  }
  
  private func initializeLayout () {
    contentView.addSubview(card)
    card.addSubview(storeImage)
    card.addSubview(verticalStackView)
    
    // stackview for delivery Fee and delivery Time
    // stackview is nicely taking care of the alignments else
    // this is getting harder and prone to errors
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    stackView.addArrangedSubview(deliveryFee)
    stackView.addArrangedSubview(deliveryTime)
    
    verticalStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    verticalStackView.addArrangedSubview(storeName)
    verticalStackView.addArrangedSubview(cuisineType)
    verticalStackView.addArrangedSubview(stackView)
    
    card.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    
    storeImage.leadingAnchor.constraint(equalTo: card.leadingAnchor , constant: 18).isActive = true
    storeImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
    storeImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
    storeImage.centerYAnchor.constraint(equalTo: card.centerYAnchor).isActive = true
    
    verticalStackView.topAnchor.constraint(equalTo: card.topAnchor, constant: genericAnchorConstraints).isActive = true
    card.bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: genericAnchorConstraints).isActive = true
    verticalStackView.leadingAnchor.constraint(equalTo: storeImage.trailingAnchor , constant: 18).isActive = true
    card.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: genericAnchorConstraints).isActive = true
  }
  
  func configureCellData(cellData: StoreBasicInfo) {
    storeName.text = cellData.name
    cuisineType.text = cellData.description
    deliveryFee.text = String(cellData.delivery_fee)
    deliveryTime.text = String(cellData.deliveryTime)
    storeImage.setImageWith(URL(string: cellData.imageUrl)!)
  }
}
