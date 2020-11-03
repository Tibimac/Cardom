//
//  ContactDetailsPresenter.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 31/10/2020.
//

import Foundation
import MapKit
import Contacts
import CoreLocation

class ContactDetailsPresenter: ContactDetailsPresenterCapable {
    
    var view: ContactDetailsViewCapable?
    
    func prepareDisplay(ofContact contact: Contact) {
        let contactViewModel = ContactViewModel(contact: contact)
        
        var sections: [ContactDetailsTableViewController.SectionType] = []
        var sectionCells: [ContactDetailsTableViewController.SectionType: [ContactDetailsTableViewController.CellType]] = [:]
        
        sections.append(.header)
        sectionCells[.header] = [
            .header(viewModel: ContactDetailsHeaderViewModel(photoURL: contactViewModel.photo,
                                                             name: contactViewModel.fullname,
                                                             ageBirthdate: "\(contactViewModel.age) ans – Né le \(contactViewModel.dob)"))
        ]
        
        sections.append(.info)
        sectionCells[.info] = [
            .info(viewModel: ContactDetailsInfoViewModel(label: "téléphone", value: contactViewModel.phone, selectionHandler: { router in
                router.startPhoneCall(number: contactViewModel.phone)
            })),
            .info(viewModel: ContactDetailsInfoViewModel(label: "e-mail", value: contactViewModel.email, selectionHandler: { router in
                router.openMailSheet(email: contactViewModel.email)
            }))
        ]
        
        if let mapOptions = contactViewModel.mapOptions {
            sections.append(.map)
            sectionCells[.map] = [
                .info(viewModel: ContactDetailsInfoViewModel(label: "ville", value: contactViewModel.city, selectionHandler: { router in
                    guard let region = contactViewModel.mapOptions?.region, region.isValid() else { return }
                    let regionSpan = MKCoordinateRegion(center: region.center,
                                                        latitudinalMeters: region.span.latitudeDelta,
                                                        longitudinalMeters: region.span.longitudeDelta)
                    let options = [
                        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                        MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
                    ]
                    let placemark = MKPlacemark(coordinate: region.center, addressDictionary: nil)
                    let mapItem = MKMapItem(placemark: placemark)
                    mapItem.name = contactViewModel.fullname
                    router.openMaps(onItem: mapItem, withOptions: options)
                })),
                .map(viewModel: ContactDetailsMapViewModel(mapOptions: mapOptions))
            ]
        }
        
        let viewModel = ContactDetailsTableViewController.ViewModel(sections: sections, sectionCells: sectionCells)
        view?.display(viewModel: viewModel)
    }
    
    func prepareToAdd(contact: Contact) {
        let cnContact = CNMutableContact()
        cnContact.contactType = .person
        cnContact.givenName = contact.name.first
        cnContact.familyName = contact.name.last
        cnContact.phoneNumbers = [CNLabeledValue(label: nil, value: CNPhoneNumber(stringValue: contact.phone)), CNLabeledValue(label: "portable", value: CNPhoneNumber(stringValue: contact.cell))]
        cnContact.emailAddresses = [CNLabeledValue(label: nil, value: contact.email as NSString)]
        cnContact.birthday = Calendar.current.dateComponents([.day, .month, .year], from: contact.dob.date)
        view?.displayAddContact(contact: cnContact)
    }
}
