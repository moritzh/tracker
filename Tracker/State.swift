//
//  State.swift
//  Tracker
//
//  Created by Moritz on 15.10.17.
//  Copyright © 2017 Moritz Haarmann. All rights reserved.
//

import Foundation
import CoreLocation

struct State {
    var trackedLocations : [CLLocationCoordinate2D]!
    var authorized : Bool!
}
