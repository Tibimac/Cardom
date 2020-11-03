//
//  UIImageView+Utils.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import UIKit
import MapKit

extension UIImageView {
    
    func loadContactPhoto(url: URL) {
        setContactPhotoPlaceholder()
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async { [weak self] in
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
                self?.alpha = 1.0
            }
        }
    }
    
    private func setContactPhotoPlaceholder() {
        DispatchQueue.main.async {
            self.image = UIImage(systemName: "person.crop.circle")
            self.tintColor = UIColor.placeholderText
            self.alpha = 0.5
        }
    }
    
    func loadMapSnapshot(options: MKMapSnapshotter.Options, forSize size: CGSize, completion: @escaping () -> Void) {
        options.size = size
        let snapshotter = MKMapSnapshotter.init(options: options)
        snapshotter.start(with: DispatchQueue.global(qos: DispatchQoS.QoSClass.background)) { [weak self] (snapshot, error) in
            DispatchQueue.main.async {
                if let image = snapshot?.image {
                    completion()
                    self?.image = image
                } else {
                    self?.contentMode = .scaleAspectFit
                    completion()
                    self?.image = UIImage(systemName: "mappin.and.ellipse") // placeholder
                }
            }
        }
    }
    
}
