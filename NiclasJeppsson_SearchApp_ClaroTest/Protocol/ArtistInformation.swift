//
//  ArtistInformation.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import UIKit

protocol ArtistInformation {
    
    var artistItem:ArtistModel { get }
    var setDelegate:ArtistBioDelegate { get set }
    func searchArtist(with artistName:String)
    func getArtistAlbums(with artistName:String)
    func getArtistBio(with artistName:String)
    func setArtistModelDataSource(with dataSource: UICollectionViewDiffableDataSource<Section, Artist>)
    func setAlbumModelDataSource(with dataSource: UICollectionViewDiffableDataSource<Section, Album>)
    func artistModelSnapShot(with artistData:[Artist])
    func artistAlbumSnapShot(with albumData:[Album])
    
}

protocol ArtistBioDelegate {
    func getBioData(bio:String, listeners:String, playcount:String)
}
