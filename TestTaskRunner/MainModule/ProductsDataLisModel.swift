//
//  File.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 29.04.2023.
//

import Foundation
struct ProgectDataListModel: Decodable{
    var id: Int?
    var image: String?
    var categories: Categories?
    var name: String?
    var description: String?
}

struct Categories: Decodable{
    var id: Int?
    var icon: String?
    var image: String?
    var name: String?
}


//MARK: - Converted data
struct ProssecedProductListData{
    var id: Int?
    var image: Data?
    var name: String?
    var description: String?
}

