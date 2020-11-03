//
//  ContactListTableViewCell.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import UIKit
import MessageUI
import Reusable

class ContactListTableViewCell: UITableViewCell, Reusable {
    
    // MARK: - Properties
    
    var viewModel: ContactViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            photoImageView.loadContactPhoto(url: viewModel.photo)
            nameLabel.text = viewModel.fullname
            emailButton.isHidden = !AppDelegate.canSendEmails
            phoneButton.isHidden = !AppDelegate.isCapableToCall
        }
    }
    
    var handleEmailButton: (() -> Void)?
    var handlePhoneButton: (() -> Void)?
    
    // MARK: - Views

    private let photoImageView: UIImageView = {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 22.5
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 45).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let emailButton: UIButton = {
        $0.setImage(UIImage(systemName: "envelope.fill"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return $0
    }(UIButton(type: .system))
    
    private let phoneButton: UIButton = {
        $0.setImage(UIImage(systemName: "phone.circle.fill"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return $0
    }(UIButton(type: .system))
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailButton)
        contentView.addSubview(phoneButton)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photoImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            nameLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),

            emailButton.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            emailButton.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 8),
            emailButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            emailButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),

            phoneButton.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            phoneButton.leadingAnchor.constraint(equalTo: emailButton.trailingAnchor, constant: 8),
            phoneButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            phoneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            phoneButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
        
        emailButton.addTarget(self, action: #selector(emailButtonHandler), for: .touchUpInside)
        phoneButton.addTarget(self, action: #selector(phoneButtonHandler), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
        nameLabel.text = nil
    }
    
    // MARK: - Actions
    
    @objc private func emailButtonHandler() {
        handleEmailButton?()
    }
    
    @objc private func phoneButtonHandler() {
        handlePhoneButton?()
    }
}
