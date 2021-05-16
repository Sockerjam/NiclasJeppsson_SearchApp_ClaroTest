//
//  ArtistAlbumVC.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 15/05/2021.
//

import UIKit

class ArtistAlbumVC: UIViewController {
    
    private lazy var collectionViewLayout:UICollectionViewCompositionalLayout = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .white
        var layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }()
    
    private lazy var collectionViewList:UICollectionView = {
        let collectionViewList = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionViewList.backgroundColor = .white
        collectionViewList.register(AlbumListReusableCell.self, forCellWithReuseIdentifier: AlbumListReusableCell.reusableCellID)
        collectionViewList.translatesAutoresizingMaskIntoConstraints = false
        return collectionViewList
    }()
    
    private lazy var artistAlbumDataSource = UICollectionViewDiffableDataSource<Section, Album>(collectionView: collectionViewList){ collectionViewList, indexPath, albumModel in
        let cell = collectionViewList.dequeueReusableCell(withReuseIdentifier: AlbumListReusableCell.reusableCellID, for: indexPath) as! AlbumListReusableCell
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
        artistBioText.numberOfLines = 10
        artistBioText.adjustsFontSizeToFitWidth = true
        artistBioText.textAlignment = .left
        artistBioText.translatesAutoresizingMaskIntoConstraints = false
        return artistBioText
    }()
    
    private lazy var artistListenersText:UILabel = {
        var text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var artistPlaycountText:UILabel = {
        var text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var albumHeader:UILabel = {
        var albumHeader = UILabel()
        albumHeader.text = "Albums"
        albumHeader.font = .preferredFont(forTextStyle: .largeTitle)
        albumHeader.translatesAutoresizingMaskIntoConstraints = false
        return albumHeader
    }()
    
    private var albumAndBioInformation:AlbumAndBioInformationProtocol = AlbumAndBioInfoImpl(networkRequest: NetworkRequest())
    
    var artistName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        albumAndBioInformation.setDelegate = self
        
        setArtistBioContraints()
        setCollectionViewConstraints()
        
        
        albumAndBioInformation.setAlbumModelDataSource(with: artistAlbumDataSource)
        albumAndBioInformation.getArtistAlbums(with: artistName)
        albumAndBioInformation.getArtistBio(with: artistName)
        
    }
    
    private func setArtistBioContraints(){
        [artistBioView, albumHeader].forEach{view.addSubview($0)}
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
            artistListenersText.topAnchor.constraint(equalTo: artistPlaycountText.bottomAnchor, constant: 10),
            albumHeader.topAnchor.constraint(equalTo: artistBioView.bottomAnchor, constant: 10),
            albumHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
            
            
        ])
        
        
    }
    
    private func setCollectionViewConstraints(){
        view.addSubview(collectionViewList)
        
        NSLayoutConstraint.activate([
            collectionViewList.topAnchor.constraint(equalTo: albumHeader.bottomAnchor),
            collectionViewList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionViewList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewList.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ArtistAlbumVC:ArtistBioDelegate{
    func getBioData(bio: String, listeners: String, playcount: String) {
        DispatchQueue.main.async {
            self.artistBioText.attributedText = NSMutableAttributedString()
                .bold("Bio: ")
                .normal(bio)
            self.artistListenersText.attributedText = NSMutableAttributedString()
                .bold("Listeners: ")
                .underlined(listeners)
            self.artistPlaycountText.attributedText = NSMutableAttributedString()
                .bold("Playcount: ")
                .underlined(playcount)
        }
    }
    
    
}

extension ArtistAlbumVC:UICollectionViewDelegate{
}
