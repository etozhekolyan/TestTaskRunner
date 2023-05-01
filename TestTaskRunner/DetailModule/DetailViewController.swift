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
        detailView?.productImage.imageFromServerURL("http://shans.d2.i-partner.ru\(presenter?.processedData?.image ?? "")", placeHolder: nil)
        detailView?.categoryIcon.imageFromServerURL("http://shans.d2.i-partner.ru\(presenter?.processedData?.categories?.icon ?? "")", placeHolder: nil)
    }
}
    //MARK: - Navigation bar configure
extension DetailViewController{
        private func configureNBTitle(){
            navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal // remove text from back button
            navigationController?.navigationBar.tintColor = .white
        }
}

