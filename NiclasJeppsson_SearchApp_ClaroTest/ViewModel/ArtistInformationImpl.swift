//
//  ArtistInformation.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import Foundation

class ArtistInformationImpl {
    
    var networkRequest:API!
    
    init(networkRequest:API){
        self.networkRequest = networkRequest
    }
}

extension ArtistInformationImpl:ArtistInformation{

    func searchArtist(with artistName: String){
        let urlString = "\(Constants.searchArtistBaseURL)\(artistName)&api_key=\(Constants.apiKey)&format=json"
        networkRequest.getData(url: urlString, resultType: ArtistModel.self) { result in
            switch result {
            case .success(let artistModel):
                print(artistModel.results.artistmatches.artist.first?.name)
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
