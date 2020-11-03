//
//  ContactDetailsInfoTableViewCell.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 02/11/2020.
//

import UIKit
import Reusable

class ContactDetailsInfoTableViewCell: UITableViewCell, Reusable {
    
    // MARK: - Properties
    
    var viewModel: ContactDetailsInfoViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            labelLabel.text = viewModel.label
            valueLabel.text = viewModel.value
        }
    }
    
    // MARK: - Views
    
    private let labelLabel: UILabel = {
        $0.textColor = .label
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let valueLabel: UILabel = {
        $0.textColor = .systemBlue
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(labelLabel)
        contentView.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            labelLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            labelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            labelLabel.bottomAnchor.constraint(equalTo: valueLabel.topAnchor, constant: -4),
            
            valueLabel.topAnchor.constraint(equalTo: labelLabel.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        labelLabel.text = nil
        valueLabel.text = nil
    }
}
