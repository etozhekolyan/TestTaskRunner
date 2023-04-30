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
    func loadPicture(path: String?) -> Data?
}

class NetworkService: NetworkServiceProtocol{
    var provider: MoyaProvider<ProductsRequests>? = MoyaProvider<ProductsRequests>()
    func getProductsListData(completion: @escaping (([ProgectDataListModel]) -> Void)) {
        provider?.request(.getProductsList, completion: { result in
            switch result{
            case .success(let successResponse):
                do{
                    try successResponse.filterSuccessfulStatusCodes()
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
}

extension ProductsRequests: TargetType{
    var baseURL: URL {URL(string: "http://shans.d2.i-partner.ru")!}
    var path: String {
        switch self {
        case .getProductsList:
            return "/api/ppp/index/"
        case .getProductInfo(let id):
            return "/api/ppp/item/?id=\(id)"
        }
    }
    var method: Moya.Method {
        switch self{
        case .getProductInfo, .getProductsList:
            return .get
        }
    }
    var task: Moya.Task {
        switch self{
        case .getProductsList, .getProductInfo:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        return ["accept": "application/json"]
    }
    
    
}
