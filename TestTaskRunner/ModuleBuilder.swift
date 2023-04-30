//
//  ModuleBuilder.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 29.04.2023.
//

import UIKit

protocol ModuleBulderProtocol{
    func buildMainVC(router: RouterProtocol?) -> UIViewController
    func buildDetailVC(id: Int, router: RouterProtocol?) -> UIViewController
}

class ModuleBuilder: ModuleBulderProtocol{
    func buildMainVC(router: RouterProtocol?) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, network: networkService, router: router)
        view.presenter = presenter
        return view
    }
    func buildDetailVC(id: Int, router: RouterProtocol?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(id: id, view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
}
