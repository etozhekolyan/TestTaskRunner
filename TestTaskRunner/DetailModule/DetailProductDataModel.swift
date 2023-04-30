//
//  DetailProductDataModel.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 29.04.2023.
//

import Foundation

struct DetailProductDataModel: Decodable{
    var id: Int?
    var image: String?
    var categories: CategoriesDetailData?
    var name: String?
    var description: String?
}

struct CategoriesDetailData: Decodable{
    var id: Int?
    var icon: String?
    var image: String?
    var name: String?
}


struct ProcessedDetailData{
    var id: Int?
    var image: Data?
    var categoriesIcon: Data?
    var categoriesName: String?
    var name: String?
    var description: String?
}
