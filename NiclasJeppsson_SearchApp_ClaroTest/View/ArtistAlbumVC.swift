//
//  ArtistAlbumVC.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 15/05/2021.
//

import UIKit

class ArtistAlbumVC: UIViewController {
    
    //Resizing Artist BiographyView Height Based On Screen Rotation
    private lazy var artistBioViewPortraitHeight = NSLayoutConstraint(item: artistBioView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 200)
    private lazy var artistBioViewLandscapeHeight = NSLayoutConstraint(item: artistBioView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 150)
    
    //CollectionView Layout
    private lazy var collectionViewLayout:UICollectionViewCompositionalLayout = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .white
        var layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }()
    
    //CollectionView List
    private lazy var collectionViewList:UICollectionView = {
        let collectionViewList = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionViewList.backgroundColor = .white
        collectionViewList.register(AlbumListReusableCell.self, forCellWithReuseIdentifier: AlbumListReusableCell.reusableCellID)
        collectionViewList.translatesAutoresizingMaskIntoConstraints = false
        return collectionViewList
    }()
    
    //CollectionView DataSource
    private lazy var artistAlbumDataSource = UICollectionViewDiffableDataSource<Section, Album>(collectionView: collectionViewList){ collectionViewList, indexPath, albumModel in
        let cell = collectionViewList.dequeueReusableCell(withReuseIdentifier: AlbumListReusableCell.reusableCellID, for: indexPath) as! AlbumListReusableCell
        cell.configureCell(with: albumModel.name, with: albumModel.image[1].imageUrl)
        return cell
    }
    
    //Artist Biography View
    private lazy var artistBioView:UIView = {
        let artistBioView = UIView(frame: .zero)
        artistBioView.backgroundColor = .white
        artistBioView.translatesAutoresizingMaskIntoConstraints = false
        return artistBioView
    }()
    
    //Artist Biography Text
    private lazy var artistBioText:UILabel = {
        var artistBioText = UILabel()
        artistBioText.numberOfLines = 10
        artistBioText.adjustsFontSizeToFitWidth = true
        artistBioText.textAlignment = .left
        artistBioText.translatesAutoresizingMaskIntoConstraints = false
        return artistBioText
    }()
    
    //Artist Listeners Text
    private lazy var artistListenersText:UILabel = {
        var text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    //Artist Playcount Text
    private lazy var artistPlaycountText:UILabel = {
        var text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    //Album Header
    private lazy var albumHeader:UILabel = {
        var albumHeader = UILabel()
        albumHeader.text = "Albums"
        albumHeader.font = .preferredFont(forTextStyle: .largeTitle)
        albumHeader.translatesAutoresizingMaskIntoConstraints = false
        return albumHeader
    }()
    
    //Dependancy Inversion
    private var albumAndBioInformation:AlbumAndBioInformationProtocol = AlbumAndBioInfoImpl(networkRequest: NetworkRequest())
    
    var artistName:String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = Colors.claroPink
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        albumAndBioInformation.setDelegate = self
        
        addSubViews()
        setArtistBioContraintsForPortraitMode()
        setCollectionViewConstraints()
        
        
        albumAndBioInformation.setAlbumModelDataSource(with: artistAlbumDataSource)
        albumAndBioInformation.getArtistAlbums(with: artistName)
        albumAndBioInformation.getArtistBio(with: artistName)
        
    }
    
    //Adds Subviews
    private func addSubViews(){
        [artistBioView, albumHeader].forEach{view.addSubview($0)}
        [artistBioText, artistPlaycountText, artistListenersText].forEach{artistBioView.addSubview($0)}
    }
    
    //Activiates Portrait Constraints
    private func portraitHeightActivate(){
        artistBioViewLandscapeHeight.isActive = false
        artistBioViewPortraitHeight.isActive = true
    }
    
    //Activiates Landscape Contraints
    private func landscapeHeightActiviate(){
        artistBioViewPortraitHeight.isActive = false
        artistBioViewLandscapeHeight.isActive = true
    }
    
    //Artist Biography Constraints For Portrait Mode
    private func setArtistBioContraintsForPortraitMode(){
      
        NSLayoutConstraint.activate([
            
            artistBioViewPortraitHeight,
            artistBioView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            artistBioView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            artistBioView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            artistBioText.topAnchor.constraint(equalTo: artistBioView.topAnchor, constant: 10),
            artistBioText.leadingAnchor.constraint(equalTo:artistBioView.leadingAnchor, constant: 10),
            artistBioText.trailingAnchor.constraint(equalTo: artistBioView.trailingAnchor, constant: -10),
            artistPlaycountText.leadingAnchor.constraint(equalTo: artistBioView.leadingAnchor, constant: 10),
            artistPlaycountText.topAnchor.constraint(equalTo: artistBioText.bottomAnchor, constant: 10),
            artistListenersText.leadingAnchor.constraint(equalTo: artistBioView.leadingAnchor, constant: 10),
            artistListenersText.topAnchor.constraint(equalTo: artistPlaycountText.bottomAnchor, constant: 10),
            albumHeader.topAnchor.constraint(equalTo: artistBioView.bottomAnchor, constant: 10),
            albumHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
    }
    
    //CollectionView Constraints
    private func setCollectionViewConstraints(){
        view.addSubview(collectionViewList)
        
        NSLayoutConstraint.activate([
            collectionViewList.topAnchor.constraint(equalTo: albumHeader.bottomAnchor),
            collectionViewList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionViewList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewList.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    //Observes Screen Rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { UIViewControllerTransitionCoordinatorContext in
            guard let screenOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {return}
            switch screenOrientation {
            case .landscapeLeft:
                self.landscapeHeightActiviate()
            case .landscapeRight:
                self.landscapeHeightActiviate()
            case .portrait:
                self.portraitHeightActivate()
            case .portraitUpsideDown:
                self.portraitHeightActivate()
            default:
                self.portraitHeightActivate()
            }
        } completion: { UIViewControllerTransitionCoordinatorContext in
            print("Rotation Completed")
        }
        super.viewWillTransition(to: size, with: coordinator)
    }
}

//Custom NSMutableAttributeString Implementation For Biography View
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
