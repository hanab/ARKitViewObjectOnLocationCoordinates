//
//  LocationTranslation.swift
//  ARKitViewObjectOnLocationCoordinates
//
//  Created by Hana Demas on 25.02.18.
//  Copyright © 2018 Hana Demas. All rights reserved.
//

import Foundation

struct LocationTranslation {
    //MARK: Properties
    var latitudeTranslation: Double
    var longitudeTranslation: Double
    var altitudeTranslation: Double
    //MARK: Init
    init(latitudeTranslation: Double, longitudeTranslation: Double, altitudeTranslation: Double) {
        self.latitudeTranslation = latitudeTranslation
        self.longitudeTranslation = longitudeTranslation
        self.altitudeTranslation = altitudeTranslation
    }
}
