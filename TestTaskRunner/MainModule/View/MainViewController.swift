//
//  ViewController.swift
//  TestTaskRunner
//
//  Created by Nickolay Vasilchenko on 28.04.2023.
//

import UIKit
protocol MainViewControllerProtocol{
    func loadingComplete()
}

class MainViewController: UIViewController {
    //MARK: - Properties
    var presenter: MainPresenterProtocol?
    private var searchView: SearchTitleView?
    private var searchBarIsEmpty: Bool {
        return searchView?.searchBar.text?.isEmpty ?? true
    }
    
    //MARK: - VC Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self
    }
    override func loadView() {
        super.loadView()
        setupMainVC()
        constrainsForCardsCollectionView()
    }
    
    //MARK: - UI Objects
    private var cardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.collectionView?.showsHorizontalScrollIndicator = false
        layout.collectionView?.showsVerticalScrollIndicator = false
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 24, left: 16, bottom: 0, right: 16)
        collectionView.register(ItemCard.self, forCellWithReuseIdentifier: ItemCard.cellID)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    //MARK: - Suppert functions
    private func setupMainVC(){
        customiseNavigationBar()
        searchView = SearchTitleView(frame: CGRect(x: 0, y: 0, width: 280, height: 41))
        searchView?.searchBar.delegate = self
        let searchButton = createSearchButton(selector: #selector(searchButtonHundler))
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.titleView = searchView
    }
    //MARK: - Action hundlers
    @objc func searchButtonHundler(){
        searchView?.titleName.isHidden = true
        searchView?.searchBar.isHidden = false
    }
    //MARK: - Constraints
    private func constrainsForCardsCollectionView(){
        self.view.addSubview(cardsCollectionView)
        cardsCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        cardsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        cardsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        cardsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
//MARK: - SearchBar delegate
extension MainViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.sendSearchRequest(searchRequset: searchText)
    }
}
//MARK: - Collection view delegate
extension MainViewController: UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let product = presenter?.productsListData?[indexPath.row]
//        presenter?.showDetail(id: product?.id ?? 0)
//    }
}
//MARK: - Collection view flow layout delegate
extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (cardsCollectionView.frame.width / 2) - 23.5, height: 296)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
//MARK: - Collection view data sourse
extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.searchBarIsEmpty {
            return self.presenter?.productsListData?.count ?? 0
        }
        return self.presenter?.filteredProductListData?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCard.cellID, for: indexPath) as! ItemCard
        
        if searchBarIsEmpty{
            cell.itemsHead.text = self.presenter?.productsListData?[indexPath.row].name ?? "--"
            cell.itemsDiscription.text = self.presenter?.productsListData?[indexPath.row].description ?? "--"
            cell.itemsPicture.image = UIImage(data: presenter?.productsListData?[indexPath.row].image ?? Data()) // это что?
        }else{
            cell.itemsHead.text = self.presenter?.filteredProductListData?[indexPath.row].name ?? "--"
            cell.itemsDiscription.text = self.presenter?.filteredProductListData?[indexPath.row].description ?? "--"
            cell.itemsPicture.image = UIImage(data: presenter?.filteredProductListData?[indexPath.row].image ?? Data()) // это что?
        }
        
        
        return cell
    }
}
//MARK: - Additon for NavigationBar
extension UIViewController{
    public func customiseNavigationBar(){
//        navigationController?.navigationBar.barTintColor = .green
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.green]
    }
    func createSearchButton(selector: Selector) -> UIBarButtonItem{
        let button = UIButton(type: .system) // magnifyingglass
        button.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let barItem = UIBarButtonItem(customView: button)
        
        return barItem
    }
}
// MARK: - MainViewControllerProtocol
extension MainViewController: MainViewControllerProtocol{
    func loadingComplete() {
        cardsCollectionView.reloadData()
    }
}
