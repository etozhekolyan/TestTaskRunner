//
//  Extension SearchBarTitle.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 29.04.2023.
//

import UIKit
class SearchTitleView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView(){
        addSubview(searchBar)
        addSubview(titleName)
    }
    public var searchBar: UISearchBar = {
       let searchBar = UISearchBar(frame: CGRect(x: 5, y: 5, width: 270, height: 30))
        searchBar.placeholder = "Search..."
        searchBar.isHidden = true
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        return searchBar
    }()
    public var titleName: UILabel = {
        let label = UILabel(frame: CGRect(x: 90, y: 5, width: 100, height: 30))
        label.text = "Химикаты"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
}
