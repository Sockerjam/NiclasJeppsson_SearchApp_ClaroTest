//
//  ViewController.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import UIKit

class ViewController: UIViewController {
    
    enum Colors {
        static let claroGreen = UIColor(red: 0.76, green: 0.88, blue: 0.77, alpha: 1.00)
    }
    
    private lazy var searchField:UITextField = {
        let searchField = UITextField(frame: .zero)
        let textAttributes = NSAttributedString(string: "Search Artist...", attributes: [.font:UIFont.boldSystemFont(ofSize: 20),.foregroundColor:UIColor.black.withAlphaComponent(0.6)])
        searchField.attributedPlaceholder = textAttributes
        searchField.backgroundColor = Colors.claroGreen
        searchField.layer.cornerRadius = 10
        searchField.textAlignment = .center
        searchField.addTarget(self, action: #selector(resignFirstResponder), for: .editingDidEndOnExit)
        searchField.delegate = self
        searchField.translatesAutoresizingMaskIntoConstraints = false
        return searchField
    }()
    
    private lazy var collectionViewLayout:UICollectionViewCompositionalLayout = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }()
    
    private lazy var collectionViewList:UICollectionView = {
        let collectionViewList = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        return collectionViewList
    }()
    
    private var artistInformation:ArtistInformation = ArtistInformationImpl(networkRequest: NetworkRequest())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationSetup()
        setupSearchTextField()
        setupCollectionView()
        
//        artistInformation.getArtistAlbums(with: "Red+Hot+Chili+Peppers")
    }

    
    private func navigationSetup(){
        
        title = "Search App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func setupCollectionView(){
        
    }
    
    private func setupSearchTextField(){
        view.addSubview(searchField)
        
        NSLayoutConstraint.activate([searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), searchField.centerXAnchor.constraint(equalTo: view.centerXAnchor), searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5), searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5), searchField.heightAnchor.constraint(equalToConstant: 40)])
    }

}

extension ViewController:UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let userInput = textField.text, !textField.text!.isEmpty else {
            print("TextField Empy")
            searchField.attributedPlaceholder = NSAttributedString(string: "You Didn't Enter Artist Name")
            return
        }
        
        artistInformation.searchArtist(with: userInput)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       return true
    }
    
    //TODO Format Input from Text Field if it's using spaces
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

