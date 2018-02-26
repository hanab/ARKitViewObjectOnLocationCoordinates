//
//  CLLocation+Extension.swift
//  ARKitViewObjectOnLocationCoordinates
//
//  Created by Hana Demas on 25.02.18.
//  Copyright © 2018 Hana Demas. All rights reserved.
//

import CoreLocation
import GLKit
import SceneKit

extension CLLocation {
    func bearingToLocationRadian(_ destinationLocation: CLLocation) -> Double {
        let lat1 = self.coordinate.latitude.toRadians()
        let lon1 = self.coordinate.longitude.toRadians()
        
        let lat2 = destinationLocation.coordinate.latitude.toRadians()
        let lon2 = destinationLocation.coordinate.longitude.toRadians()
        let dLon = lon2 - lon1
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        let radiansBearing = atan2(y, x)
        return radiansBearing
    }
    
    public func translatedLocation(with latitudeTranslation: Double, longitudeTranslation: Double, altitudeTranslation: Double) -> CLLocation {
        let latitudeCoordinate = self.coordinate.coordinate(with: 0, and: latitudeTranslation)
        let longitudeCoordinate = self.coordinate.coordinate(with: 90, and: longitudeTranslation)
        let coordinate = CLLocationCoordinate2D(
            latitude: latitudeCoordinate.latitude,
            longitude: longitudeCoordinate.longitude)
        let altitude = self.altitude + altitudeTranslation
        return CLLocation(coordinate: coordinate, altitude: altitude, horizontalAccuracy: self.horizontalAccuracy, verticalAccuracy: self.verticalAccuracy, timestamp: self.timestamp)
    }
    
    func translation(toLocation location: CLLocation) -> LocationTranslation {
        let inbetweenLocation = CLLocation(latitude: self.coordinate.latitude, longitude: location.coordinate.longitude)
        let distanceLatitude = location.distance(from: inbetweenLocation)
        let latitudeTranslation: Double
        if location.coordinate.latitude > inbetweenLocation.coordinate.latitude {
            latitudeTranslation = distanceLatitude
        } else {
            latitudeTranslation = 0 - distanceLatitude
        }
        let distanceLongitude = self.distance(from: inbetweenLocation)
        let longitudeTranslation: Double
        if self.coordinate.longitude > inbetweenLocation.coordinate.longitude {
            longitudeTranslation = 0 - distanceLongitude
        } else {
            longitudeTranslation = distanceLongitude
        }
        let altitudeTranslation = location.altitude - self.altitude
        return LocationTranslation(
            latitudeTranslation: latitudeTranslation,
            longitudeTranslation: longitudeTranslation,
            altitudeTranslation: altitudeTranslation)
    }
}
