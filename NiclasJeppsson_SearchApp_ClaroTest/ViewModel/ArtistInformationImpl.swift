//
//  ArtistInformation.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import UIKit

class ArtistInformationImpl {
    
    private var artistModelDataSource:UICollectionViewDiffableDataSource<Section, Artist>?
    private var listItems:[Artist] = []
    
    var networkRequest:API!
    
    init(networkRequest:API){
        self.networkRequest = networkRequest
    }
    
}

extension ArtistInformationImpl:ArtistInformation{
    
    func setArtistModelDataSource(with dataSource: UICollectionViewDiffableDataSource<Section, Artist>) {
        artistModelDataSource = dataSource
    }
    
    func artistModelSnapShot(with artistData: [Artist]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Artist>()
        snapShot.appendSections([.main])
        snapShot.appendItems(artistData)
        artistModelDataSource?.apply(snapShot)
    }
    

    func searchArtist(with artistName: String){
        let urlString = "\(Constants.searchArtistBaseURL)\(artistName)&api_key=\(Constants.apiKey)&format=json"
        networkRequest.getData(url: urlString, resultType: ArtistModel.self) { result in
            switch result {
            case .success(let artistModel):
                self.artistModelSnapShot(with: artistModel.results.artistmatches.artist)
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
                for album in artistAlbums.topAlbums.album {
                    print(album.name)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
