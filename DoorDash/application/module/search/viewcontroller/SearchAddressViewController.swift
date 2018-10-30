//
//  SearchAddressViewController.swift
//  DoorDash
//
//  Created by Adhyam Nagarajan, Padmaja on 10/27/18.
//  Copyright © 2018 Adhyam Nagarajan, Padmaja. All rights reserved.
//

import UIKit
import GoogleMaps

class SearchAddressViewController: UIViewController {
  
  var locationManager = CLLocationManager()
  var mapView: GMSMapView?
  let camera = GMSCameraPosition.camera(withLatitude: 37.585600,
                                        longitude: -122.011151,
                                        zoom: 15.0)
  
  lazy var marker: GMSMarker = {
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: 37.585600, longitude: -122.011151)
    marker.title = "Home"
    marker.snippet = "Union City"
    marker.map = mapView
    marker.isDraggable = true
    return marker
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
    
    mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    mapView?.translatesAutoresizingMaskIntoConstraints = false
    mapView?.settings.myLocationButton = true
    mapView?.isMyLocationEnabled = true
    mapView?.delegate = self
    
    navigationController?.navigationItem.title = "Choose an Address"
    
    locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()
    locationManager.distanceFilter = 50
    locationManager.startUpdatingLocation()
    locationManager.delegate = self
    
    // Add the map to the view, hide it until we've got a location update.
    if let mapView = self.mapView {
      view.addSubview(mapView)
    }
    view.addSubview(confirmButton)
    
    addConstraintsForMapView()
    addConstraintsForConfirmButton()
  }
  
  private func addConstraintsForMapView() {
    mapView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
    mapView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    mapView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    mapView?.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: 0).isActive = true
  }
  
  private func addConstraintsForConfirmButton() {
    confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
    confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    confirmButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    confirmButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
  }

  @objc func confirmAddress(_ sender: AnyObject?) {
    NSLog("inside click of the button")
    navigationController?.pushViewController(StoreTabBarViewController(lat: marker.position.latitude, long: marker.position.longitude), animated: true)
  }
}

extension SearchAddressViewController: CLLocationManagerDelegate {
  // Handle incoming location events.
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let lastLocation = locations.last else { return }
    
    let camera = GMSCameraPosition.camera(withLatitude: lastLocation.coordinate.latitude,
                                          longitude: lastLocation.coordinate.longitude,
                                          zoom: 15.0)
    
    guard let mapView1 = self.mapView else { return }
    if mapView1.isHidden {
      mapView1.isHidden = false
      mapView1.camera = camera
    } else {
      mapView1.animate(to: camera)
    }
  }
  
  // Handle authorization for the location manager.
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .restricted:
      NSLog("Location access was restricted.")
    case .denied:
      NSLog("User denied access to location.")
    case .notDetermined:
      NSLog("User state not determined.")
      
    case .authorizedAlways: fallthrough
    case .authorizedWhenInUse:
      NSLog("Location status is OK.")
    }
  }
  
  // Handle location manager errors.
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    locationManager.stopUpdatingLocation()
    NSLog("Error: \(error)")
  }
}

extension SearchAddressViewController: GMSMapViewDelegate {

  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
    marker.position = coordinate
  }
}
