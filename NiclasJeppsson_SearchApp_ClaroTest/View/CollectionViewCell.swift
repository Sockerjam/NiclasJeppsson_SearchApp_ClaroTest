//
//  CollectionViewCell.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let collectionViewReusableCellID = "reusableCollectionViewCell"
    
    private var artistImage:UIImageView = {
        let artistImage = UIImageView()
        artistImage.contentMode = .scaleAspectFit
        artistImage.translatesAutoresizingMaskIntoConstraints = false
        return artistImage
    }()
    
    private var artistName:UILabel = {
        let artistName = UILabel()
        artistName.translatesAutoresizingMaskIntoConstraints = false
        return artistName
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with artistName:String){
        self.artistName.text = artistName
        self.artistImage.image = UIImage(systemName: "plus")
    }
    
    
    private func setConstraints(){
        
        [artistImage, artistName].forEach {addSubview($0)}
        
        NSLayoutConstraint.activate([heightAnchor.constraint(equalToConstant: 60),artistImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5), artistImage.topAnchor.constraint(equalTo: topAnchor, constant: 5), artistImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5), artistImage.heightAnchor.constraint(equalTo: heightAnchor), artistImage.widthAnchor.constraint(equalToConstant: 60), artistName.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 20)])
    }
    
    
}
