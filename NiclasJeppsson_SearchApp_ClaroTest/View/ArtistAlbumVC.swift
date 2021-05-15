//
//  ArtistAlbumVC.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 15/05/2021.
//

import UIKit

class ArtistAlbumVC: UIViewController {
    
    private lazy var collectionViewLayout:UICollectionViewCompositionalLayout = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.headerMode = .supplementary
        configuration.backgroundColor = .white
        var layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        headerElement.pinToVisibleBounds = true
        layout.configuration.boundarySupplementaryItems = [headerElement]
        return layout
    }()
    
    private lazy var collectionViewList:UICollectionView = {
        let collectionViewList = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionViewList.backgroundColor = .white
        collectionViewList.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.collectionViewReusableCellID)
        collectionViewList.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.headerReusableViewID)
        collectionViewList.translatesAutoresizingMaskIntoConstraints = false
        return collectionViewList
    }()
    
    private lazy var artistAlbumDataSource = UICollectionViewDiffableDataSource<Section, Album>(collectionView: collectionViewList){ collectionViewList, indexPath, albumModel in
        let cell = collectionViewList.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.collectionViewReusableCellID, for: indexPath) as! CollectionViewCell
        cell.configureCell(with: albumModel.name, with: albumModel.image[1].imageUrl)
        return cell
    }
    
    private lazy var artistBioView:UIView = {
        let artistBioView = UIView(frame: .zero)
        artistBioView.backgroundColor = .white
        artistBioView.translatesAutoresizingMaskIntoConstraints = false
        return artistBioView
    }()
    
    private lazy var artistBioText:UILabel = {
        var artistBioText = UILabel()
        artistBioText.font = UIFont(name: "Helvetica", size: 12)
        artistBioText.text = "Bio: "
        artistBioText.numberOfLines = 10
        artistBioText.adjustsFontSizeToFitWidth = true
        artistBioText.textAlignment = .left
        artistBioText.translatesAutoresizingMaskIntoConstraints = false
        return artistBioText
    }()
    
    private lazy var artistListenersText:UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "Helvetica", size: 12)
        text.text = "Listeners: "
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var artistPlaycountText:UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "Helvetica", size: 12)
        text.text = "Playcount: "
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private var artistInformation:ArtistInformation = ArtistInformationImpl(networkRequest: NetworkRequest())
    
    var artistName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        artistInformation.setDelegate = self
        
        setHeaderConfiguration()
        
        setArtistBioContraints()
        setCollectionViewConstraints()
        
        
        artistInformation.setAlbumModelDataSource(with: artistAlbumDataSource)
        artistInformation.getArtistAlbums(with: artistName)
        artistInformation.getArtistBio(with: artistName)
        
    }
    
    private func setHeaderConfiguration(){
        
        artistAlbumDataSource.supplementaryViewProvider = {collectionViewList, elementKind, indexPath in
            let headerView = collectionViewList.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.headerReusableViewID, for: indexPath)
            return headerView
        }
    }
    
    private func setArtistBioContraints(){
        view.addSubview(artistBioView)
        [artistBioText, artistPlaycountText, artistListenersText].forEach{artistBioView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            artistBioView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            artistBioView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            artistBioView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            artistBioView.heightAnchor.constraint(equalToConstant: 200),
            artistBioText.topAnchor.constraint(equalTo: artistBioView.topAnchor, constant: 10),
            artistBioText.leadingAnchor.constraint(equalTo:artistBioView.leadingAnchor, constant: 10),
            artistBioText.trailingAnchor.constraint(equalTo: artistBioView.trailingAnchor, constant: -10),
            artistPlaycountText.leadingAnchor.constraint(equalTo: artistBioView.leadingAnchor, constant: 10),
            artistPlaycountText.topAnchor.constraint(equalTo: artistBioText.bottomAnchor, constant: 10),
            artistListenersText.leadingAnchor.constraint(equalTo: artistBioView.leadingAnchor, constant: 10),
            artistListenersText.topAnchor.constraint(equalTo: artistPlaycountText.bottomAnchor, constant: 10)
            
            
        ])
        
        
    }
    
    private func setCollectionViewConstraints(){
        view.addSubview(collectionViewList)
        
        NSLayoutConstraint.activate([
            collectionViewList.topAnchor.constraint(equalTo: artistBioView.bottomAnchor),
            collectionViewList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionViewList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewList.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ArtistAlbumVC:ArtistBioDelegate{
    func getBioData(bio: String, listeners: String, playcount: String) {
        DispatchQueue.main.async {
            self.artistBioText.text! += bio
            self.artistListenersText.text! += listeners
            self.artistPlaycountText.text! += playcount
        }
    }
    
    
}

extension ArtistAlbumVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
    }
}
