//
//  MainPresenter.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 29.04.2023.
//

import Foundation

protocol MainPresenterProtocol{
    var products: [ProductsModel]? { get set }
    var filteredProducts: [ProductsModel]? { get set }
    init(view: MainViewControllerProtocol, network: NetworkServiceProtocol, router: RouterProtocol?)
    func showDetail(id: Int)
    func sendSearchRequest(searchRequset: String)
}

class MainPresenter: MainPresenterProtocol{
    var products: [ProductsModel]?
    var filteredProducts: [ProductsModel]?
    var view: MainViewControllerProtocol?
    var network: NetworkServiceProtocol?
    var router: RouterProtocol?
    
    required init(view: MainViewControllerProtocol, network: NetworkServiceProtocol, router: RouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
        sendRequest()
    }
    
    private func sendRequest(){
        network?.getProductsList(completion: { [weak self] receivedData in
            self?.products = receivedData
            self?.view?.loadingComplete()
        })
    }
    
    func sendSearchRequest(searchRequset: String) {
        network?.getFilteredData(searchRequest: searchRequset, completion: { [weak self] filteredData in
            self?.filteredProducts = filteredData
            self?.view?.loadingComplete()
        })
    }
    func showDetail(id: Int){
        router?.initializeDetailVC(id: id)
    }
}
