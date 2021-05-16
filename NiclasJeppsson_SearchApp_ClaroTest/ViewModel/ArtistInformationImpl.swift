//
//  ArtistInformation.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import UIKit

class ArtistInformationImpl {
    
    private var artistModelDataSource:UICollectionViewDiffableDataSource<Section, Artist>?
    private var listItems:ArtistModel?
    
    var networkRequest:API!
    
    init(networkRequest:API){
        self.networkRequest = networkRequest
    }
    
}

extension ArtistInformationImpl:ArtistInformation{
    
    var artistItem: ArtistModel {
        return listItems!
    }
    
    
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
                self.listItems = artistModel
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
