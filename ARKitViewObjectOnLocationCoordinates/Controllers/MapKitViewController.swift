//
//  ViewController.swift
//  ARKitViewObjectOnLocationCoordinates
//
//  Created by Hana Demas on 25.02.18.
//  Copyright © 2018 Hana Demas. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapKitViewController: UIViewController, CLLocationManagerDelegate {
    //MARK: IBoutlets
    @IBOutlet weak var locatioSelectionMapView: MKMapView!
    //MARK:Properies
    let locationManager = CLLocationManager()
    var userLocation = CLLocation()
    var destinationLocation: CLLocationCoordinate2D?
    var press: UILongPressGestureRecognizer!
    
    //MARK: ViewController life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start location services
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        //gesture regognizer
        press = UILongPressGestureRecognizer(target: self, action: #selector(handleMapTap(gesture:)))
        press.minimumPressDuration = 0.1
        
        locatioSelectionMapView.showsUserLocation = true
        locatioSelectionMapView.addGestureRecognizer(press)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArView" {
            if let destination = segue.destination as? ArKitSceneViewController{
                destination.startingLocation = userLocation
                if let destiationLocation = self.destinationLocation {
                    destination.destinationLocation = destiationLocation
                }
            }
        }
    }
    
    //MARK: gesture regognizer
    @objc func handleMapTap(gesture: UIGestureRecognizer) {
        if gesture.state != UIGestureRecognizerState.began {
            return
        }
        let touchPoint = gesture.location(in: locatioSelectionMapView)
        // Convert map tap point to coordinate
        let coord: CLLocationCoordinate2D = locatioSelectionMapView.convert(touchPoint, toCoordinateFrom: locatioSelectionMapView)
        destinationLocation = coord
    }
    
    //MARK: IBAction
    @IBAction func showARViewPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showArView", sender: self)
    }
    
    //MARK: Custom functions
    private func centerMapInInitialCoordinates() {
        self.locatioSelectionMapView.setCenter(self.userLocation.coordinate, animated: true)
        
        let latDelta: CLLocationDegrees = 0.04
        let lonDelta: CLLocationDegrees = 0.04
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let region = MKCoordinateRegionMake(self.userLocation.coordinate, span)
        self.locatioSelectionMapView.setRegion(region, animated: false)
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    //MARK: - CLLocationManager
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLocation = location
            centerMapInInitialCoordinates()
        }
    }
}
