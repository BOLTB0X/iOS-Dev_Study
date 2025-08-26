//
//  ImageCell.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/26/25.
//

import UIKit

// MARK: - ImageCell
final class ImageCell: UITableViewCell {
    static let identifier = "ImageCell"
    
    private let thumbnailImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 6
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .secondarySystemBackground // placeholder
        return iv
    }() // thumbnailImage
    
    private let filenameText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }() // filenameText
    
    private let useCase = LoadImageUseCase()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        contentView.addSubview(thumbnailImage)
        contentView.addSubview(filenameText)
        
        NSLayoutConstraint.activate([
            thumbnailImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            thumbnailImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            thumbnailImage.widthAnchor.constraint(equalToConstant: 380),
            thumbnailImage.heightAnchor.constraint(equalToConstant: 250),
            
            filenameText.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor, constant: 8),
            filenameText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            filenameText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    } // setupLayout
    
    // MARK: - configure
    func configure(with entity: ImageEntity) {
        filenameText.text = entity.filename
        
        Task {
            if let url = URL(string: entity.imageURL) {
                do {
                    let image = try await useCase.execute(from: url)
                    thumbnailImage.image = image
                } catch {
                    thumbnailImage.image = UIImage(systemName: "photo")
                } //
            } // if - let
        } // Task
        
    } // Configure
    
} // ImageCell
