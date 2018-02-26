//
//  ArKitSceneViewController.swift
//  ARKitViewObjectOnLocationCoordinates
//
//  Created by Hana Demas on 25.02.18.
//  Copyright © 2018 Hana Demas. All rights reserved.
//

import UIKit
import ARKit
import CoreLocation

class ArKitSceneViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var sceneView: ARSCNView!
    //MARK: Properties
    var destinationLocation: CLLocationCoordinate2D?
    var startingLocation: CLLocation!
    private var locationNode:LocationNode?
    private let configuration = ARWorldTrackingConfiguration()
    
    //MARK: viewControllor lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
        
        guard let latitude = self.destinationLocation?.latitude, let longitude = self.destinationLocation?.longitude else {
            return
            
        }
        let destination = CLLocation(latitude: latitude, longitude: longitude)
        self.addNode(for: destination)
    }
    
    //MARK: Custom functions
    private func setupScene() {
        sceneView.delegate = self
        sceneView.showsStatistics = true
        let scene = SCNScene()
        sceneView.scene = scene
        runSession()
    }
    
    func runSession() {
        configuration.worldAlignment = .gravityAndHeading
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    //function to add a 3d object
    //to test if it is adding the object 'self.addNode(for: startingLocation)' which will palce on the current user location and adjust position of the node in 'transformMatrix' fuction
    private func addNode(for location: CLLocation) {
        let locationTransform = MatrixHelper.transformMatrix(for: matrix_identity_float4x4, originLocation: startingLocation, location: location)
        let position = SCNVector3.positionFromTransform(locationTransform)
        
        self.locationNode = LocationNode(location: location)
        guard let locationNode = self.locationNode else {
            return
        }
        locationNode.addNode(with:"art.scnassets/Car.dae", and: "Car")
        locationNode.location = location
        locationNode.position = position
        
        let distance = locationNode.location.distance(from: startingLocation)
        let scale = 10 / Float(distance)
        locationNode.scale = SCNVector3(x: scale, y: scale, z: scale)
        
        sceneView.scene.rootNode.addChildNode(locationNode)
    }
}

extension ArKitSceneViewController: ARSCNViewDelegate {
    // MARK: - ARSCNViewDelegate
   func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .normal:
            print("ready")
        case .notAvailable:
            print("wait")
        case .limited(let reason):
            print("limited tracking state: \(reason)")
        }
    }
}
