//
//  Networkservice.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 29.04.2023.
//

import Foundation
import Moya

protocol NetworkServiceProtocol{
    func getProductsListData(completion: @escaping (([ProgectDataListModel]) -> Void))
    func getDetailData(id: Int, completion: @escaping ((DetailProductDataModel) -> Void))
    func getFilteredProductList(searchRequest: String, completion: @escaping (([ProgectDataListModel]) -> Void))
    func loadPicture(path: String?) -> Data?
}

class NetworkService: NetworkServiceProtocol{
    var provider: MoyaProvider<ProductsRequests>? = MoyaProvider<ProductsRequests>(plugins: [NetworkLoggerPlugin()])
    
    func getProductsListData(completion: @escaping (([ProgectDataListModel]) -> Void)) {
        provider?.request(.getProductsList, completion: { result in
            switch result{
            case .success(let successResponse):
                do{
                    let decodedResponse = try JSONDecoder().decode([ProgectDataListModel].self, from: successResponse.data)
                    completion(decodedResponse)
                }catch(let jsonError){
                    print(jsonError)
                }
            case .failure(let failureResponse):
                print(failureResponse)
            }
        })
    }
    
    func getDetailData(id: Int, completion: @escaping ((DetailProductDataModel) -> Void)) {
        provider?.request(.getProductInfo(id: id), completion: { result in
            switch result{
            case .success(let successResponse):
                do{
                    let decodedResponse = try JSONDecoder().decode(DetailProductDataModel.self, from: successResponse.data)
                    completion(decodedResponse)
                }catch(let jsonError){
                    print(jsonError)
                }
            case .failure(let failureResponse):
                print(failureResponse)
            }
        })
    }
    
    func getFilteredProductList(searchRequest: String, completion: @escaping (([ProgectDataListModel]) -> Void)) {
        provider?.request(.getFilteredList(searchRequest: searchRequest), completion: { result in
            switch result{
            case .success(let sucssesResponse):
                do{
                    let decodedData = try JSONDecoder().decode([ProgectDataListModel].self, from: sucssesResponse.data)
                    
                    completion(decodedData)
                }catch(let jsonError){
                    print("Here \(jsonError)")
                }
            case .failure(let failureResponse):
                print("Here \(failureResponse)")
            }
        })
    }
    
    func loadPicture(path: String?) -> Data? {
        guard let checkedPath = path else {return nil}
        let completePath = "http://shans.d2.i-partner.ru\(checkedPath)"
        let encodedURL = completePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: encodedURL) else {return nil}
        return try? Data(contentsOf: url)
    }
}


enum ProductsRequests{
    case getProductsList
    case getProductInfo(id: Int)
    case getFilteredList(searchRequest: String)
}

extension ProductsRequests: TargetType{
    var baseURL: URL {URL(string: "http://shans.d2.i-partner.ru")!}
    var path: String {
        switch self {
        case .getProductsList:
            return "/api/ppp/index/"
        case .getProductInfo(let id):
            return "/api/ppp/item/?id=\(id)"
        case .getFilteredList:
            return "/api/ppp/index/"
        }
    }
    var method: Moya.Method {
        switch self{
        case .getProductInfo, .getProductsList, .getFilteredList:
            return .get
        }
    }
    var task: Moya.Task {
        switch self{
        case .getFilteredList(let searchRequest):
            return .requestParameters(parameters: ["search" : searchRequest], encoding: URLEncoding.queryString)
        case .getProductsList, .getProductInfo:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        return ["accept": "application/json"]
    }
    
    
}
