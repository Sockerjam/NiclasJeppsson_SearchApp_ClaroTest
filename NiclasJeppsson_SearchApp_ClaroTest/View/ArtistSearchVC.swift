//
//  ViewController.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import UIKit

class ArtistSearchVC: UIViewController {
    
    //Artist Search Field
    private lazy var searchField:UITextField = {
        let searchField = UITextField(frame: .zero)
        let textAttributes = NSAttributedString(string: "Enter Artist Name", attributes:
        [.font:UIFont.boldSystemFont(ofSize: 20),.foregroundColor:UIColor.black.withAlphaComponent(0.6)])
        searchField.attributedPlaceholder = textAttributes
        searchField.backgroundColor = Colors.claroGreen
        searchField.layer.cornerRadius = 10
        searchField.textAlignment = .center
        searchField.addTarget(self, action: #selector(resignFirstResponder), for: .editingDidEndOnExit)
        searchField.delegate = self
        searchField.translatesAutoresizingMaskIntoConstraints = false
        return searchField
    }()
    
    //CollectionView Layout
    private lazy var collectionViewLayout:UICollectionViewCompositionalLayout = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .white
        var layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }()
    
    //CollectionViewList
    private lazy var collectionViewList:UICollectionView = {
        let collectionViewList = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionViewList.backgroundColor = .white
        collectionViewList.delegate = self
        collectionViewList.register(ArtistsListReusableCell.self, forCellWithReuseIdentifier: ArtistsListReusableCell.reusableCellID)
        collectionViewList.translatesAutoresizingMaskIntoConstraints = false
        return collectionViewList
    }()
    
    //CollectionViewDataSource
    private lazy var artistModelDataSource = UICollectionViewDiffableDataSource<Section, Artist>(collectionView: collectionViewList){ collectionViewList, indexPath, artistModel in
        let cell = collectionViewList.dequeueReusableCell(withReuseIdentifier: ArtistsListReusableCell.reusableCellID, for: indexPath) as! ArtistsListReusableCell
        cell.configureCell(with: artistModel.name, with: Constants.placeholderArtistImage)
        return cell
    }
    
    //Dependency Inversion
    private var artistInformation:ArtistInformation = ArtistInformationImpl(networkRequest: NetworkRequest())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setSearchFieldConstraints()
        setCollectionViewConstraints()
        artistInformation.setArtistModelDataSource(with: artistModelDataSource)
    }
    
    
    //NavigationBar Setup
    private func setNavigationBar(){
        
        title = "Search App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    //CollectionView Constraints
    private func setCollectionViewConstraints(){
        view.addSubview(collectionViewList)
        
        NSLayoutConstraint.activate([
        collectionViewList.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10),
        collectionViewList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        collectionViewList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        collectionViewList.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    //SearchField Constraints
    private func setSearchFieldConstraints(){
        view.addSubview(searchField)
        
        NSLayoutConstraint.activate([
        searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        searchField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        searchField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
        searchField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
        searchField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    //Formats Search Text To Work With URL
    private func setTextFormat(searchTerm:String) -> String {
        
        var formattedSearchTerm:String = ""
        
       _ = searchTerm.map{
            if String($0) == " " {
                formattedSearchTerm.append("+")
            } else {
                formattedSearchTerm.append(String($0))
            }
        }
        
        return formattedSearchTerm
    }
    
}

extension ArtistSearchVC:UITextFieldDelegate{
    
    //Checks That SearchField Is Not Empty
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let userInput = textField.text, !textField.text!.isEmpty else {
            print("TextField Empy")
            searchField.attributedPlaceholder = NSAttributedString(string: "You Didn't Enter Artist Name")
            return
        }
        
        artistInformation.searchArtist(with: setTextFormat(searchTerm: userInput))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension ArtistSearchVC:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let artistString = artistInformation.artistItem.results.artistmatches.artist[indexPath.item].name
        
        let formattedArtist = setTextFormat(searchTerm: artistString)
        
        //Initilise ArtistAlbum ViewController
        let vc = ArtistAlbumVC()
        vc.artistName = formattedArtist
        vc.modalPresentationStyle = .fullScreen
        vc.title = artistString
        navigationController?.pushViewController(vc, animated: true)
    }
   
}

