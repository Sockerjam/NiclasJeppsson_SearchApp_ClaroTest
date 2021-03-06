//
//  Constants.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import UIKit

struct Constants {
    
    static let apiKey = "d9657a81514e8b46030e6f3c03a6d64c"
    static let searchArtistBaseURL = "https://ws.audioscrobbler.com/2.0/?method=artist.search&artist="
    static let getArtistAlbumsBaseURL = "https://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist="
    static let getArtistBioBaseURL = "https://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist="
    static let placeholderArtistImage = "https://cdn.pixabay.com/photo/2015/01/13/13/20/music-598176_1280.jpg"
    static let textFormat = "Helvetica"
}

enum Colors {
    static let claroGreen = UIColor(red: 0.76, green: 0.88, blue: 0.77, alpha: 1.00)
    static let claroPink = UIColor(red: 0.87, green: 0.00, blue: 0.30, alpha: 1.00)
}
