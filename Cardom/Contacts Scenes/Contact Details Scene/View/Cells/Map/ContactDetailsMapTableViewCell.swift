//
//  ContactDetailsMapTableViewCell.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 02/11/2020.
//

import UIKit
import Reusable

class ContactDetailsMapTableViewCell: UITableViewCell, Reusable {
    
    // MARK: - Properties
    
    private static let mapHeight: CGFloat = 200.0
    private let margin: CGFloat = 8.0
    
    var viewModel: ContactDetailsMapViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            loader.startAnimating()
            mapImageView.loadMapSnapshot(options: viewModel.mapOptions,
                                         forSize: CGSize(width: contentView.bounds.width - (margin * 2),
                                                         height: ContactDetailsMapTableViewCell.mapHeight),
                                         completion: { [weak self] in self?.loader.stopAnimating() })
        }
    }
    
    // MARK: - Views
    
    private let loader: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIActivityIndicatorView(style: .large))
    
    private let mapImageView: UIImageView = {
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: mapHeight).isActive = true
        return $0
    }(UIImageView())
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(loader)
        contentView.addSubview(mapImageView)
        
        NSLayoutConstraint.activate([
            loader.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            mapImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            mapImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            mapImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            mapImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        mapImageView.image = nil
    }
}
