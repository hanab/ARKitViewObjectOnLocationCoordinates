//
//  LocationNode.swift
//  ARKitViewObjectOnLocationCoordinates
//
//  Created by Hana Demas on 25.02.18.
//  Copyright © 2018 Hana Demas. All rights reserved.
//
import SceneKit
import UIKit
import ARKit
import CoreLocation

class LocationNode: SCNNode {
    //MARK: Properties
    var location: CLLocation
    //MARK: Init
    init(location: CLLocation) {
        self.location = location
        super.init()
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        constraints = [billboardConstraint]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: function to create nodes from scn files
    func createNode(filePath: String, rootNodeName: String) -> SCNNode? {
        let locationScene = SCNScene(named: filePath)
        let locationNode = locationScene?.rootNode.childNode(withName: rootNodeName, recursively: true)
       
        return locationNode
    }
    
    func addNode(with filePath: String, and rootNodeName: String) {
        guard let locationNode = createNode(filePath: filePath, rootNodeName: rootNodeName) else { return
        }
        addChildNode(locationNode)
    }
}
