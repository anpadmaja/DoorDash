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
  
  var locationManager = CLLocationManager()
  
  lazy var marker: GMSMarker = {
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: 37.585600, longitude: -122.011151)
    marker.title = "Home"
    marker.snippet = "Union City"
    marker.map = mapView
    marker.isDraggable = true
    return marker
  }()
  
  var lastLocation: CLLocation?
  let camera = GMSCameraPosition.camera(withLatitude: 37.585600,
                                        longitude: -122.011151,
                                        zoom: 15.0)
  var mapView: GMSMapView?
  
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
    view.addSubview(mapView!)
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
    print("inside click of the button")
    navigationController?.pushViewController(StoreTabBarViewController(lat: marker.position.latitude, long: marker.position.longitude), animated: true)
  }
}

extension ViewController: CLLocationManagerDelegate {
  // Handle incoming location events.
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let lastLocation = locations.last!
    
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
      print("Location access was restricted.")
    case .denied:
      print("User denied access to location.")
      // Display the map using the default location.
    
    case .notDetermined: fallthrough
    case .authorizedAlways: fallthrough
    case .authorizedWhenInUse:
      print("Location status is OK.")
    }
  }
  
  // Handle location manager errors.
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    locationManager.stopUpdatingLocation()
    print("Error: \(error)")
  }
}

extension ViewController: GMSMapViewDelegate {
  func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
    print("didBeginDragging")
  }
  func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
    print("didDrag")
  }
  func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
    print("didEndDragging")
  }
  
  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
    marker.position = coordinate
  }
}
