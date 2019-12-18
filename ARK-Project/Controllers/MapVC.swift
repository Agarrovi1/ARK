//
//  MapVC.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapVC: UIViewController {
    
    //MARK: - Properties
    let searchRadius: CLLocationDistance = 2000
    var initialLocation = CLLocation(latitude: 40.742054, longitude: -73.769417)
    private var locationManager = CLLocationManager()
    
    
    //MARK: - Objects
    var placeSearchBar: UISearchBar = {
        let bar = UISearchBar()
        return bar
    }()
    var mapView = MKMapView()
    lazy var dangerGauge = DangerGaugeView(frame: CGRect(x: 0, y: 0, width: 50, height: 180))
    
    //MARK: - Constraints
    private func setConstraints() {
        setSearchBarConstraints()
        setMapConstraints()
        setGaugeConstraints()
    }
    private func setSearchBarConstraints() {
        view.addSubview(placeSearchBar)
        placeSearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            placeSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            placeSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
    private func setMapConstraints() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: placeSearchBar.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: placeSearchBar.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: placeSearchBar.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    private func setGaugeConstraints() {
        mapView.addSubview(dangerGauge)
        dangerGauge.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dangerGauge.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -50),
            dangerGauge.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            dangerGauge.widthAnchor.constraint(equalToConstant: dangerGauge.frame.width),
            dangerGauge.heightAnchor.constraint(equalToConstant: dangerGauge.frame.height)])
    }
    //MARK: - Setup
    private func setDelegates() {
        mapView.delegate = self
        locationManager.delegate = self
    }
    
    //MARK: - Methods
    private func zoomIn(locationCoordinate: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: locationCoordinate.coordinate, latitudinalMeters: self.searchRadius * 2.0, longitudinalMeters: self.searchRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    private func locationAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedWhenInUse,.authorizedAlways:
            mapView.showsUserLocation = true
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
          //  zoomIn(locationCoordinate: initialLocation)
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }

    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        setDelegates()
        locationAuthorization()
        mapView.userTrackingMode = .follow
        
    }
    

    

}
//MARK: - Extensions
extension MapVC: MKMapViewDelegate {
    
}

//MARK: - CoreLocation
extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("New location: \(locations)")
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization status changed to \(status.rawValue)")
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            zoomIn(locationCoordinate: initialLocation)
            //Call a function to get the current location
            
        default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
}
