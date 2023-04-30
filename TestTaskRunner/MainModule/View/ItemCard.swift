//
//  ItemCard.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 28.04.2023.
//

import Foundation
import UIKit

class ItemCard: UICollectionViewCell{
    static let cellID = "ItemCardCell"
// MARK: - UI Elements
    private var itemView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.backgroundColor = .white
        return view
    }()
    public var itemsPicture: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    public var itemsHead: UILabel = {
        let label = UILabel(frame: .zero)
        label.layer.borderWidth = 1
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 13.0)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public var itemsDiscription: UILabel = {
        let label = UILabel(frame: .zero)
        label.layer.borderWidth = 1 
        label.numberOfLines = 0
        label.font = UIFont(name: "SF-Pro-Display", size: 12.0)
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
        setupItemView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - Support functions and constraints
    private func setupItemView(){
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
        addSubview(itemsPicture)
        addSubview(itemsHead)
        addSubview(itemsDiscription)
    }
    private func setupContrains(){
        itemView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        itemView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        itemView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        itemsPicture.widthAnchor.constraint(equalToConstant: 140).isActive = true
        itemsPicture.heightAnchor.constraint(equalToConstant: 82).isActive = true
        itemsPicture.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        itemsPicture.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        itemsPicture.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        itemsPicture.bottomAnchor.constraint(equalTo: itemsHead.topAnchor, constant: -12).isActive = true
        
        itemsHead.widthAnchor.constraint(equalToConstant: 140).isActive = true
        itemsHead.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        itemsHead.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        itemsHead.bottomAnchor.constraint(equalTo: itemsDiscription.topAnchor,constant: 5).isActive = true
        
        itemsDiscription.widthAnchor.constraint(equalToConstant: 140).isActive = true
        itemsDiscription.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        itemsDiscription.topAnchor.constraint(equalTo: itemsHead.bottomAnchor, constant: 6).isActive = true
        itemsDiscription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        itemsDiscription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        itemsDiscription.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
