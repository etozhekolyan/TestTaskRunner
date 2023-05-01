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
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(ItemCard.self, forCellWithReuseIdentifier: ItemCard.cellID)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    //MARK: - Suppert functions
    private func setupMainVC(){
//        customiseNavigationBar()
        searchView = SearchTitleView(frame: CGRect(x: 0, y: 0, width: 280, height: 41))
        searchView?.searchBar.delegate = self
        let searchButton = createSearchButton(selector: #selector(searchButtonHundler))
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.titleView = searchView
    }
    private func setupPath(path: String?) -> String? {
        let completePath = "http://shans.d2.i-partner.ru\(path!)"
        return completePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    //MARK: - Action hundlers
    @objc func searchButtonHundler() {
        searchView?.titleName.isHidden = true
        searchView?.searchBar.isHidden = false
        searchView?.searchBar.becomeFirstResponder()
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchBarIsEmpty{
            let unit = presenter?.dataList?[indexPath.row].id ?? 0
            presenter?.showDetail(id: unit)
        }else{
            let unit = presenter?.filterDataList?[indexPath.row].id ?? 0
            presenter?.showDetail(id: unit)
        }
    }
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
        if searchBarIsEmpty{
            return presenter?.dataList?.count ?? 0
        }else{
            return presenter?.filterDataList?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCard.cellID, for: indexPath) as! ItemCard
        var unit: ProgectDataListModel
        
        if searchBarIsEmpty{
            unit = presenter?.dataList?[indexPath.row] ?? ProgectDataListModel()
        }else{
            unit = presenter?.filterDataList?[indexPath.row] ?? ProgectDataListModel()
        }
        
        cell.itemsHead.text = unit.name
        cell.itemsDiscription.text = unit.description
        cell.itemsPicture.imageFromServerURL("http://shans.d2.i-partner.ru\(unit.categories!.image!)", placeHolder: nil)
        
        return cell
    }
}
//MARK: - Additon for NavigationBar
extension UIViewController{
    public func customiseNavigationBar(){
        navigationController?.navigationBar.tintColor = .green
    }
    func createSearchButton(selector: Selector) -> UIBarButtonItem{
        let button = UIButton(type: .system) // magnifyingglass
        button.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
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


extension UIImageView {

    
        func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {

        self.image = nil
        //If imageurl's imagename has space then this line going to work for this
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        

        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(error)")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                       
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
