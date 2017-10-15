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
    
    var errorViewController = ErrorViewController()
    
    var presenter : Presenter?
    
    override func viewDidLoad() {
  
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
        
        if presenter == nil {
            { [unowned self] in
                let presenterImplementation = PresenterImplementation()
                presenterImplementation.stateUpdatable = self
                self.presenter = presenterImplementation
            }()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.presenter?.prepare()
        
        errorViewController.willMove(toParentViewController: self)
        view.addSubview(errorViewController.view)
        errorViewController.view.frame = view.frame
        addChildViewController(errorViewController)
        errorViewController.didMove(toParentViewController: self)
        
        errorViewController.view.isHidden = true
    }

    
    @IBAction func addButtonAction(_ sender: Any) {
        self.presenter?.addCurrentLocation()
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

extension ViewController : StateUpdatable {
    
    func updateWithState(_ state: State) {
        let annotations = state.trackedLocations.map { (coordinate) -> MKAnnotation in
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = coordinate
            return pointAnnotation
        }
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(annotations)
        
        self.errorViewController.view.isHidden = state.authorized
    }
}

