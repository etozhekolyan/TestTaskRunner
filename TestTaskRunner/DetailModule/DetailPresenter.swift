//
//  DetailPresenter.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 29.04.2023.
//

import Foundation
protocol DetailPresenterProtocol{
    var processedData: DetailProductDataModel? { get set }
    init(id: Int, view: DetailViewControllerProtocol?, networkService: NetworkServiceProtocol?, router: RouterProtocol?)
}

class DetailPresenter: DetailPresenterProtocol{
    
    var view: DetailViewControllerProtocol?
    var networkService: NetworkServiceProtocol?
    var router: RouterProtocol?
    var id: Int?
    var processedData: DetailProductDataModel?
    
    required init(id: Int, view: DetailViewControllerProtocol?, networkService: NetworkServiceProtocol?, router: RouterProtocol?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.id = id // ?
        sendRequest(id: id)
    }
    
    private func sendRequest(id: Int){
        networkService?.getDetailData(id: id, completion: { [weak self] detailProductData in
            self?.processedData = detailProductData
            self?.view?.loadingComplete()
        })
    }
    
//    private func setupDetailData(receivedData: DetailProductDataModel) -> ProcessedDetailData{
//
//        return ProcessedDetailData(
//            id: receivedData.id,
//            image: networkService?.loadPicture(path: receivedData.image),
//            categoriesIcon: networkService?.loadPicture(path: receivedData.categories?.icon),
//            categoriesName: receivedData.name,
//            name: receivedData.name,
//            description: receivedData.description
//        )
//    }
}
