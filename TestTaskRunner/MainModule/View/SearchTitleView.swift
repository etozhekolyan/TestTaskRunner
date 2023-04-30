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
        addSubview(searchField)
        addSubview(titleName)
    }
   public var searchField: UITextField = {
       let textField = UITextField(frame: CGRect(x: 5, y: 5, width: 270, height: 30))
        textField.placeholder = "Search..."
        textField.clearButtonMode = .whileEditing
        textField.isHidden = true
        return textField
    }()
    public var titleName: UILabel = {
        let label = UILabel(frame: CGRect(x: 90, y: 5, width: 100, height: 30))
        label.text = "Default"
        label.textAlignment = .center
        return label
    }()
}
