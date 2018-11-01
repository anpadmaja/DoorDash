//
//  StoreViewCell.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 10/28/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import UIKit

let storeViewCellReuseIdentifier = "StoreViewCell"

protocol StoreViewCellDelegate : class {
  func isMarkedFavorite(cellData: StoreBasicInfo)
}

class StoreViewCell: UITableViewCell {
  
  let genericAnchorConstraints: CGFloat = 12
  weak var storeCellDelegate: StoreViewCellDelegate?
  private var cellData: StoreBasicInfo?
  
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
    stackview.spacing = 6
    stackview.isUserInteractionEnabled = true
    return stackview
  }()
  
  lazy var storeImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  lazy var embeddedHorzStackView: UIStackView = {
    let stackview = UIStackView()
    stackview.translatesAutoresizingMaskIntoConstraints = false
    stackview.axis = .horizontal
    stackview.alignment = .fill
    stackview.distribution = .equalSpacing
    stackview.spacing = 20
    stackview.isUserInteractionEnabled = true
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
    a.textColor = UIColor.black.withAlphaComponent(0.56)
    a.textAlignment = .natural
    a.numberOfLines = 0
    a.font = UIFont(name:"HelveticaNeue", size: 16.0)
    return a
  }()
  
  lazy var deliveryFee: UILabel = {
    let a = UILabel()
    a.translatesAutoresizingMaskIntoConstraints = false
    a.textColor = UIColor.black.withAlphaComponent(0.8)
    a.textAlignment = .natural
    a.numberOfLines = 1
    a.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
    a.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
    a.lineBreakMode = .byTruncatingTail
    a.font = UIFont(name:"HelveticaNeue", size: 16.0)
    return a
  }()
  
  lazy var deliveryTime: UILabel = {
    let a = UILabel()
    a.translatesAutoresizingMaskIntoConstraints = false
    a.textColor = UIColor.black.withAlphaComponent(0.8)
    a.textAlignment = .natural
    a.numberOfLines = 1
    a.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
    a.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
    a.lineBreakMode = .byTruncatingTail
    a.font = UIFont(name:"HelveticaNeue", size: 16.0)
    return a
  }()
  
  lazy var favorite: UIButton = {
    let a = UIButton()
    a.translatesAutoresizingMaskIntoConstraints = false
    var templateImage = UIImage(named: "tab-star")?.withRenderingMode(.alwaysOriginal)
    a.setImage(templateImage, for: .normal)
    a.imageView?.tintColor = UIColor.red
    a.isUserInteractionEnabled = true
    a.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
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
  
  @objc private func addToFavorites() {
    guard let info = cellData else { return }
    storeCellDelegate?.isMarkedFavorite(cellData: info)
    favorite.tintColor = UIColor.blue
  }
  
  private func initializeLayout () {
    contentView.addSubview(card)
    card.addSubview(storeImage)
    card.addSubview(verticalStackView)
    
    // horizontal stackview for delivery Fee and delivery Time
    // stackview is nicely taking care of the alignments else
    // this is getting harder and prone to errors
    embeddedHorzStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    embeddedHorzStackView.addArrangedSubview(deliveryFee)
    embeddedHorzStackView.addArrangedSubview(deliveryTime)
    embeddedHorzStackView.addArrangedSubview(favorite)
    
    verticalStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    verticalStackView.addArrangedSubview(storeName)
    verticalStackView.addArrangedSubview(cuisineType)
    verticalStackView.addArrangedSubview(embeddedHorzStackView)
    
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
    self.cellData = cellData
    storeName.text = cellData.name
    cuisineType.text = cellData.description
    
    let fee = NSLocalizedString("deliveryFee", comment: "")
    let time = NSLocalizedString("deliveryTime", comment: "")
    
    deliveryFee.text = String(format: fee, arguments: [String(cellData.deliveryFee)])
    deliveryTime.text = String(format: time, arguments: [String(cellData.deliveryTime)])
    
    if let imageWithURL = URL(string: cellData.imageUrl) {
      storeImage.setImageWith(imageWithURL)
    } else {
      storeImage.image = UIImage(named: "defaultImage")
    }
  }
}
