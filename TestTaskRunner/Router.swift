//
//  Router.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 29.04.2023.
//

import UIKit

protocol BaseRouterProtocol{
    var navigationController: UINavigationController? { get set }
    var builder: ModuleBulderProtocol? { get set }
}

protocol RouterProtocol: BaseRouterProtocol{
    func initializeMainVC()
    func initializeDetailVC(id: Int)
}

class Router: RouterProtocol{
    var navigationController: UINavigationController?
    var builder: ModuleBulderProtocol?
    
    init(navigationController: UINavigationController?, builder: ModuleBulderProtocol?) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initializeMainVC() {
        if let navigationController = navigationController{
            guard let mainVC = builder?.buildMainVC(router: self) else {return}
            navigationController.viewControllers = [mainVC]
        }
    }
    func initializeDetailVC(id: Int){
        if let navigationController = navigationController{
            guard let detailVC = builder?.buildDetailVC(id: id, router: self) else {return}
            navigationController.pushViewController(detailVC, animated: true)
        }
    }
}
