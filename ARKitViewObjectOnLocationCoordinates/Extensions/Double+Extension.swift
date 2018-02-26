//
//  Double+Extension.swift
//  ARKitViewObjectOnLocationCoordinates
//
//  Created by Hana Demas on 25.02.18.
//  Copyright © 2018 Hana Demas. All rights reserved.
//

import Foundation

extension Double {
    func toRadians() -> Double {
        return self * .pi / 180.0
    }
    
    func toDegrees() -> Double {
        return self * 180.0 / .pi
    }
}
