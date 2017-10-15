//
//  Presenter.swift
//  Tracker
//
//  Created by Moritz on 15.10.17.
//  Copyright © 2017 Moritz Haarmann. All rights reserved.
//

import Foundation
import CoreLocation

protocol Presenter {
    func prepare ()
    
    func addCurrentLocation ()
}

protocol StateUpdatable {
    func updateWithState(_ state: State)
}

class PresenterImplementation : NSObject, Presenter {
    
    var stateUpdatable : StateUpdatable?
    
    let locationManager = CLLocationManager()
    
    var trackedLocations : [CLLocationCoordinate2D] = []
    
    func prepare () {
        locationManager.delegate = self
        
        if (CLLocationManager.authorizationStatus() == .notDetermined){
            locationManager.requestWhenInUseAuthorization()
        }
        
        self.updateState()
    }
    
    func addCurrentLocation () {
        if let coordinate = locationManager.location?.coordinate {
            self.trackedLocations.append(coordinate)
            self.updateState()
        }
    }
    
    private func updateState () {
        var state = State()
        
        state.authorized = CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        state.trackedLocations = trackedLocations
        
        self.stateUpdatable?.updateWithState(state)
    }
}

extension PresenterImplementation : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.updateState()
    }
}
