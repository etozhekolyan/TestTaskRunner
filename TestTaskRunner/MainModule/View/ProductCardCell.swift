//
//  ItemCard.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 28.04.2023.
//

import Foundation
import UIKit

class ProductCardCell: UICollectionViewCell{
    static let cellID = "ProductCardCell"
// MARK: - UI Elements
    private var itemView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.backgroundColor = .white
        return view
    }()
    public var productPicture: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    public var productNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 13.0)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public var productDiscriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 15.0)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContrains()
        setupCellView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - Support functions and constraints
    private func setupCellView(){
        self.layer.cornerRadius = 6
        self.clipsToBounds = false
        dropShadows()
    }
    private func dropShadows(){
        self.layer.shadowColor = UIColor(red: 0.282,
                                         green: 0.298,
                                         blue: 0.298,
                                         alpha: 0.15).cgColor
        self.layer.shadowRadius = 7.0
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        let cgPath = UIBezierPath(roundedRect: self.bounds,
                                  byRoundingCorners: [.allCorners],
                                  cornerRadii: CGSize(width: 6, height: 6)).cgPath
        self.layer.shadowPath = cgPath
    }
    private func setupViews(){
        addSubview(itemView)
        addSubview(productPicture)
        addSubview(productNameLabel)
        addSubview(productDiscriptionLabel)
    }
    private func setupContrains(){
        itemView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        itemView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        itemView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        productPicture.widthAnchor.constraint(equalToConstant: 140).isActive = true
        productPicture.heightAnchor.constraint(equalToConstant: 82).isActive = true
        productPicture.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        productPicture.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        productPicture.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        productPicture.bottomAnchor.constraint(equalTo: productNameLabel.topAnchor, constant: -12).isActive = true
        
        productNameLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        productNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        productNameLabel.bottomAnchor.constraint(equalTo: productDiscriptionLabel.topAnchor,constant: -5).isActive = true
        
        productDiscriptionLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        productDiscriptionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        productDiscriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 6).isActive = true
        productDiscriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        productDiscriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        productDiscriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
    }
}
