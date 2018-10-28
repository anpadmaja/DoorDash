//
//  ViewController.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 10/27/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
  
  lazy var mapView: GMSMapView = {
    let camera = GMSCameraPosition.camera(withLatitude: 37.585600, longitude: -122.011151, zoom: 14)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    mapView.translatesAutoresizingMaskIntoConstraints = false
    return mapView
  }()
  
  lazy var confirmButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = UIColor.red
    button.setTitle("Confirm Address", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(confirmAddress(_:)), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(mapView)
    view.addSubview(confirmButton)
    addConstraintsForMapView()
    addConstraintsForConfirmButton()
    
    // Creates a marker in the center of the map.
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: 37.585600, longitude: -122.011151)
    marker.title = "Home"
    marker.snippet = "Union City"
    marker.map = mapView
    
    navigationController?.navigationItem.title = "Choose an Address"
  }
  
  private func addConstraintsForMapView() {
    mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
    mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    mapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
    mapView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: 0).isActive = true
  }
  
  private func addConstraintsForConfirmButton() {
    confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
    confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    confirmButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    confirmButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
  }

  @objc func confirmAddress(_ sender: AnyObject?) {
    print("inside click of the button")
    navigationController?.pushViewController(NearByStoreListViewController(), animated: true)
  }
}

