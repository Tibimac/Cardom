//
//  UIImageView+Utils.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import UIKit

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async { [weak self] in
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { self?.setPlaceholder(); return }
            DispatchQueue.main.async {
                self?.image = image
                self?.alpha = 1.0
                self?.contentMode = .scaleAspectFit
            }
        }
    }
    
    func setPlaceholder() {
        DispatchQueue.main.async {
            self.image = UIImage(systemName: "person.crop.circle.fill")
            self.tintColor = .white
            self.alpha = 0.25
        }
    }
    
}
