//
//  MainPresenter.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 29.04.2023.
//

import Foundation

protocol MainPresenterProtocol{
    var productsListData: [ProssecedProductListData]? { get set }
    init(view: MainViewControllerProtocol, network: NetworkServiceProtocol, router: RouterProtocol?)
    func showDetail(id: Int)
}

class MainPresenter: MainPresenterProtocol{
    var productsListData: [ProssecedProductListData]?
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
        network?.getProductsListData(completion: { [weak self] productListDataSet in
            self?.productsListData = self?.processProductListDataSet(receivedData: productListDataSet)
            self?.view?.loadingComplete()
        })
    }
    
    private func processProductListDataSet(receivedData: [ProgectDataListModel]) -> [ProssecedProductListData]{
        var result: [ProssecedProductListData] = []
        receivedData.map { item in
            result.append(ProssecedProductListData(id: item.id,
                                                   image: self.network?.loadPicture(path: item.categories?.image),
                                                   name: item.name,
                                                   description: item.description))
        }
        
        return result
    }
    
    func showDetail(id: Int){
        router?.initializeDetailVC(id: id)
    }
}
