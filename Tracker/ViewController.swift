//
//  ViewController.swift
//  Tracker
//
//  Created by Moritz on 15.10.17.
//  Copyright © 2017 Moritz Haarmann. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addButton: UIButton!
    
    var errorViewController : ErrorViewController?
    
    let locationManager = CLLocationManager()
    
    var markedLocations : [CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
  
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        
        var shouldShowErrorScreen = true
        
        if (CLLocationManager.authorizationStatus() == .notDetermined){
            locationManager.requestWhenInUseAuthorization()
        } else if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
            shouldShowErrorScreen = false
        }
        
        if (shouldShowErrorScreen){
            showErrorScreen()
        }
    }
    
    func showErrorScreen () {
        guard errorViewController == nil else {
            return
        }
        errorViewController = ErrorViewController()
        
        if let errorViewController = errorViewController {
            errorViewController.willMove(toParentViewController: self)
            view.addSubview(errorViewController.view)
            addChildViewController(errorViewController)
            errorViewController.didMove(toParentViewController: self)
        }
    }
    
    func hideErrorScreen () {
        guard errorViewController != nil else {
            return
        }
        
        if let errorViewController = errorViewController {
            errorViewController.willMove(toParentViewController: nil)
            errorViewController.view.removeFromSuperview()
            errorViewController.removeFromParentViewController()
            errorViewController.didMove(toParentViewController: nil)
        }
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        self.markedLocations.append(mapView.userLocation.coordinate)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapView.userLocation.coordinate
        
        self.mapView.addAnnotation(annotation)
    }
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse){
            hideErrorScreen()
        } else {
            showErrorScreen()
        }
    }
}

extension ViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKPointAnnotation {
            return MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        } else {
            return nil
        }
    }
}

