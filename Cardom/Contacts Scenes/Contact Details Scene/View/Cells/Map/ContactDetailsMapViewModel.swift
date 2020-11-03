//
//  ContactDetailsMapViewModel.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 02/11/2020.
//

import Foundation
import MapKit

struct ContactDetailsMapViewModel {
    let mapOptions: MKMapSnapshotter.Options
    
    init(mapOptions: MKMapSnapshotter.Options) {
        mapOptions.pointOfInterestFilter = MKPointOfInterestFilter(including: [])
        self.mapOptions = mapOptions
    }
}
