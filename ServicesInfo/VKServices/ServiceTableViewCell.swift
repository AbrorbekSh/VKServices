//
//  ServiceTableViewCell.swift
//  ServicesInfo
//
//  Created by Аброрбек on 31.03.2024.
//

import UIKit

final class ServiceTableViewCell: UITableViewCell {
    private let serviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(serviceImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            serviceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            serviceImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            serviceImageView.widthAnchor.constraint(equalToConstant: 60),
            serviceImageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: serviceImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func configure(with service: Service) {
        DispatchQueue.main.async {
            self.titleLabel.text = service.name
            self.subtitleLabel.text = service.description
        }
    }
    
    func setImage(image: UIImage) {
        DispatchQueue.main.async {
            self.serviceImageView.image = image
        }
    }
}
