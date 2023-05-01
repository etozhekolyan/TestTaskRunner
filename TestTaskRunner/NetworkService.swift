//
//  Networkservice.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 29.04.2023.
//

import Foundation
import Moya

protocol NetworkServiceProtocol{
    func getProductsList(completion: @escaping (([ProductsModel]) -> Void))
    func getDetailData(id: Int, completion: @escaping ((DetailProductDataModel) -> Void))
    func getFilteredData(searchRequest: String, completion: @escaping (([ProductsModel]) -> Void))
}

class NetworkService: NetworkServiceProtocol{
    var provider: MoyaProvider<ProductsRequests>? = MoyaProvider<ProductsRequests>(plugins: [NetworkLoggerPlugin()])
    
    func getProductsList(completion: @escaping (([ProductsModel]) -> Void)) {
        provider?.request(.getProductsList, completion: { result in
            switch result{
            case .success(let successResponse):
                do{
                    let decodedResponse = try JSONDecoder().decode([ProductsModel].self, from: successResponse.data)
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
        provider?.request(.getDetailData(id: id), completion: { result in
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
    
    func getFilteredData(searchRequest: String, completion: @escaping (([ProductsModel]) -> Void)) {
        provider?.request(.getFilteredData(searchRequest: searchRequest), completion: { result in
            switch result{
            case .success(let sucssesResponse):
                do{
                    let decodedData = try JSONDecoder().decode([ProductsModel].self, from: sucssesResponse.data)
                    
                    completion(decodedData)
                }catch(let jsonError){
                    print("Here \(jsonError)")
                }
            case .failure(let failureResponse):
                print("Here \(failureResponse)")
            }
        })
    }
}


enum ProductsRequests{
    case getProductsList
    case getDetailData(id: Int)
    case getFilteredData(searchRequest: String)
}

extension ProductsRequests: TargetType{
    var baseURL: URL {URL(string: "http://shans.d2.i-partner.ru")!}
    var path: String {
        switch self {
        case .getProductsList:
            return "/api/ppp/index/"
        case .getDetailData(let id):
            return "/api/ppp/item/?id=\(id)"
        case .getFilteredData:
            return "/api/ppp/index/"
        }
    }
    var method: Moya.Method {
        switch self{
        case .getDetailData, .getProductsList, .getFilteredData:
            return .get
        }
    }
    var task: Moya.Task {
        switch self{
        case .getFilteredData(let searchRequest):
            return .requestParameters(parameters: ["search" : searchRequest], encoding: URLEncoding.queryString)
        case .getProductsList, .getDetailData:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        return ["accept": "application/json"]
    }
    
    
}
