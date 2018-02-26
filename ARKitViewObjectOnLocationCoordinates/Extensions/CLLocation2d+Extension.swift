//
//  CLLocation2d+Extension.swift
//  ARKitViewObjectOnLocationCoordinates
//
//  Created by Hana Demas on 25.02.18.
//  Copyright © 2018 Hana Demas. All rights reserved.
//


import CoreLocation

extension CLLocationCoordinate2D {
    func bearingToLocationRadian(_ destinationLocation: CLLocationCoordinate2D) -> Double {
        
        let lat1 = latitude.toRadians()
        let lon1 = longitude.toRadians()
        let lat2 = destinationLocation.latitude.toRadians()
        let lon2 = destinationLocation.longitude.toRadians()
        
        let dLon = lon2 - lon1
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        let radiansBearing = atan2(y, x)
        return radiansBearing
    }
    
    func coordinate(with bearing: Double, and distance: Double) -> CLLocationCoordinate2D {
        let distRadiansLat = distance / LocationConstants.metersPerRadianLat
        let distRadiansLong = distance / LocationConstants.metersPerRadianLon
        let lat1 = self.latitude.toRadians()
        let lon1 = self.longitude.toRadians()
        let lat2 = asin(sin(lat1) * cos(distRadiansLat) + cos(lat1) * sin(distRadiansLat) * cos(bearing))
        let lon2 = lon1 + atan2(sin(bearing) * sin(distRadiansLong) * cos(lat1), cos(distRadiansLong) - sin(lat1) * sin(lat2))
        return CLLocationCoordinate2D(latitude: lat2.toDegrees(), longitude: lon2.toDegrees())
    }
}
