//
//  ContactDetailsHeaderTableViewCell.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 02/11/2020.
//

import UIKit
import Reusable

class ContactDetailsHeaderTableViewCell: UITableViewCell, Reusable {
    
    // MARK: - Properties
    
    var viewModel: ContactDetailsHeaderViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            photoImageView.loadContactPhoto(url: viewModel.photoURL)
            nameLabel.text = viewModel.name
            birthInfoLabel.text = viewModel.ageBirthdate
        }
    }
    
    // MARK: - Views
    
    private let photoImageView: UIImageView = {
        $0.layer.cornerRadius = 60
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 120).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 25)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let birthInfoLabel: UILabel = {
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(birthInfoLabel)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -16),
            
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: birthInfoLabel.topAnchor, constant: -8),
            
            birthInfoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            birthInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            birthInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            birthInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
