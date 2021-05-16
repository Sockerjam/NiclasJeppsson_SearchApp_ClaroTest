//
//  AlbumAndBioInfoImpl.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 16/05/2021.
//

import UIKit

class AlbumAndBioInfoImpl {
    
    private var artistAlbumDataSource:UICollectionViewDiffableDataSource<Section, Album>?
    
    var delegate:ArtistBioDelegate!
    var networkRequest:API!
    
    init(networkRequest:API){
        self.networkRequest = networkRequest
    }
    
}

extension AlbumAndBioInfoImpl:AlbumAndBioInformationProtocol{
    
    var setDelegate: ArtistBioDelegate {
        get {
            return delegate
        }
        set {
            delegate = newValue
        }
    }
    
    func setAlbumModelDataSource(with dataSource: UICollectionViewDiffableDataSource<Section, Album>) {
        artistAlbumDataSource = dataSource
    }
    
    func getArtistAlbums(with artistName: String) {
        let urlString = "\(Constants.getArtistAlbumsBaseURL)\(artistName)&api_key=\(Constants.apiKey)&format=json"
        networkRequest.getData(url: urlString, resultType: ArtistAlbums.self) { result in
            switch result{
            case .success(let artistAlbums):
                self.artistAlbumSnapShot(with: artistAlbums.topAlbums.album)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getArtistBio(with artistName: String) {
        let urlString = "\(Constants.getArtistBioBaseURL)\(artistName)&api_key=\(Constants.apiKey)&format=json"
        networkRequest.getData(url: urlString, resultType: ArtistBio.self) { result in
            switch result{
            case .success(let artistBio):
                self.delegate.getBioData(bio: artistBio.artist.bio.summary, listeners: artistBio.artist.stats.listeners, playcount: artistBio.artist.stats.playcount)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func artistAlbumSnapShot(with albumData: [Album]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Album>()
        snapShot.appendSections([.main])
        snapShot.appendItems(albumData)
        artistAlbumDataSource?.apply(snapShot)
    }
    
    
    
}
