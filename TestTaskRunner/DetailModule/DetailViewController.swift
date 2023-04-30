//
//  DetailViewController.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 29.04.2023.
//

import UIKit

protocol DetailViewControllerProtocol{
   func loadingComplete()
}

class DetailViewController: UIViewController {
    var presenter: DetailPresenterProtocol?
    var detailView: DetailView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNBTitle()
    }
    override func loadView() {
        super.loadView()
        detailView = DetailView()
        self.view = detailView
    }
}
//MARK: - DetailViewControllerProtocol
extension DetailViewController: DetailViewControllerProtocol{
    func loadingComplete() {
        detailView?.nameLabel.text = presenter?.processedData?.name ?? "--"
        detailView?.discriptionLabel.text = presenter?.processedData?.description ?? "--"
        detailView?.productImage.image = UIImage(data: presenter?.processedData?.image ?? Data())
        detailView?.categoryIcon.image = UIImage(data: presenter?.processedData?.categoriesIcon ?? Data())
    }
}

//MARK: - Navigation bar configure
extension DetailViewController{
    private func configureNBTitle(){
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal // remove text from back button
    }
}
