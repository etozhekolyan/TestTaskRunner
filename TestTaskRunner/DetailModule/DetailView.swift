//
//  DetailView.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 30.04.2023.
//

import UIKit

class DetailView: UIView {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewConfigure()
        dropButtonsShadow()
        setupViews()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SubViews
    var productImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var categoryIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .topLeft
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    public var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.layer.borderWidth = 1
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public var discriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.layer.borderWidth = 1
        label.numberOfLines = 0
        label.font = UIFont(name: "SF-Pro-Display", size: 15.0)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public var buyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Где купить?", for: .normal)
//        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont(name: "SF-Pro-Display", size: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "Vector"), for: .normal)
        return button
    }()
    public var favoritesButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "starPic"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Visual effects
    private func dropButtonsShadow(){
        buyButton.layer.shadowColor = UIColor(red: 0.282,
                                         green: 0.298,
                                         blue: 0.298,
                                         alpha: 0.15).cgColor
        buyButton.layer.shadowRadius = 7.0
        buyButton.layer.shadowOpacity = 0.7
        buyButton.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        let cgPath = UIBezierPath(roundedRect: buyButton.bounds,
                                  byRoundingCorners: [.allCorners],
                                  cornerRadii: CGSize(width: 6, height: 6)).cgPath
        buyButton.layer.shadowPath = cgPath
    }
    
    //MARK: - View Configure
    private func viewConfigure(){
        self.backgroundColor = .white
    }
    private func setupViews(){
        self.addSubview(categoryIcon)
        self.addSubview(productImage)
        self.addSubview(favoritesButton)
        self.addSubview(nameLabel)
        self.addSubview(discriptionLabel)
        self.addSubview(buyButton)
    }
    
    //MARK: - Constrsints
    private func setConstraints(){
        productImage.widthAnchor.constraint(equalToConstant: 117).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: 183).isActive = true
        productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 124).isActive = true
        productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 127).isActive = true
        productImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -131).isActive = true
        productImage.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -32).isActive = true
        
        categoryIcon.widthAnchor.constraint(equalToConstant: 140).isActive = true
        categoryIcon.heightAnchor.constraint(equalToConstant: 140).isActive = true
        categoryIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 116).isActive = true
        categoryIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        categoryIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -208).isActive = true
        categoryIcon.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -82).isActive = true
        
        favoritesButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        favoritesButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        favoritesButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 126).isActive = true
        favoritesButton.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 66).isActive = true
        favoritesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35).isActive = true
        favoritesButton.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -185).isActive = true
        
        nameLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 32).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -181).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: discriptionLabel.topAnchor, constant: -8).isActive = true
        
        discriptionLabel.widthAnchor.constraint(equalToConstant: 328).isActive = true
        discriptionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        discriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        discriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14).isActive = true
        discriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -33).isActive = true
        discriptionLabel.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -15).isActive = true
        
        buyButton.widthAnchor.constraint(equalToConstant: 117).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buyButton.topAnchor.constraint(equalTo: discriptionLabel.bottomAnchor, constant: 15).isActive = true
        buyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        //        buyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250).isActive = true
        
    }
}
