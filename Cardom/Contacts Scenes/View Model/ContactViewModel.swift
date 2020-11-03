//
//  ContactViewModel.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import UIKit
import MapKit
import CoreLocation

struct ContactViewModel: Equatable {
    let photo: URL
    let age: Int
    let dob: String
    let fullname: String
    let phone: String
    let email: String
    let city: String
    let mapOptions: MKMapSnapshotter.Options?
    
    internal init(contact: Contact) {
        /* As photo are small (even the "large" one) we always use
         * URL of largest one to have a nice retina comppliant display. */
        self.photo = URL(string: contact.picture.large)!
        self.age = Calendar.current.dateComponents([.year], from: contact.dob.date , to: Date()).year!
        self.dob = contact.dob.date.string
        self.fullname = contact.name.first + " " + contact.name.last
        self.phone = contact.phone
        self.email = contact.email
        self.city = contact.location.city + " " + contact.nat.emojiFlag
        
        if let latitude = Double(contact.location.coordinates.latitude), let longitude = Double(contact.location.coordinates.longitude) {
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 100000, longitudinalMeters: 100000)
            guard region.isValid() else { self.mapOptions = nil; return }
            let snapshotOptions = MKMapSnapshotter.Options()
            snapshotOptions.region = region
            self.mapOptions = snapshotOptions
        } else {
            self.mapOptions = nil
        }
    }
}

fileprivate extension Date {
    var string: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "FR")
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}

fileprivate extension String {
    var emojiFlag: String {
        let base : UInt32 = 127397
        var s = ""
        self.uppercased().unicodeScalars.forEach {
            s.unicodeScalars.append(UnicodeScalar(base + $0.value)!)
        }
        return s
    }
}
