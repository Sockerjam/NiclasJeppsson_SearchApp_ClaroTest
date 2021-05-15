//
//  ArtistInformation.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import UIKit

class ArtistInformationImpl {
    
    private var artistModelDataSource:UICollectionViewDiffableDataSource<Section, Artist>?
    private var artistAlbumDataSource:UICollectionViewDiffableDataSource<Section, Album>?
    private var listItems:ArtistModel?
    
    var delegate:ArtistBioDelegate!
    
    var networkRequest:API!
    
    init(networkRequest:API){
        self.networkRequest = networkRequest
    }
    
}

extension ArtistInformationImpl:ArtistInformation{
    
    var setDelegate: ArtistBioDelegate {
        get {
            return delegate
        }
        set {
            delegate = newValue
        }
    }
    
  
        
    var artistItem: ArtistModel {
       return listItems!
    }
    
    
    func setArtistModelDataSource(with dataSource: UICollectionViewDiffableDataSource<Section, Artist>) {
        artistModelDataSource = dataSource
    }
    
    func setAlbumModelDataSource(with dataSource: UICollectionViewDiffableDataSource<Section, Album>) {
        artistAlbumDataSource = dataSource
    }
    
    func artistModelSnapShot(with artistData: [Artist]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Artist>()
        snapShot.appendSections([.main])
        snapShot.appendItems(artistData)
        artistModelDataSource?.apply(snapShot)
    }
    
    func artistAlbumSnapShot(with albumData: [Album]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Album>()
        snapShot.appendSections([.main])
        snapShot.appendItems(albumData)
        artistAlbumDataSource?.apply(snapShot)
    }
    

    func searchArtist(with artistName: String){
        let urlString = "\(Constants.searchArtistBaseURL)\(artistName)&api_key=\(Constants.apiKey)&format=json"
        networkRequest.getData(url: urlString, resultType: ArtistModel.self) { result in
            switch result {
            case .success(let artistModel):
                self.artistModelSnapShot(with: artistModel.results.artistmatches.artist)
                self.listItems = artistModel
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
    
}
