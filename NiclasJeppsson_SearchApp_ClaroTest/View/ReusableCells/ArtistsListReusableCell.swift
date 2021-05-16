//
//  CollectionViewCell.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import UIKit
import SDWebImage

class ArtistsListReusableCell: UICollectionViewCell {
    
    static let reusableCellID = "ArtistsListReusableCell"
    
    private var artistImage:UIImageView = {
        let artistImage = UIImageView()
        artistImage.layer.cornerRadius = 10
        artistImage.clipsToBounds = true
        artistImage.contentMode = .scaleAspectFit
        artistImage.translatesAutoresizingMaskIntoConstraints = false
        return artistImage
    }()
    
    private var artistName:UILabel = {
        let artistName = UILabel()
        let textAttribute = NSAttributedString(string: "", attributes: [.font:UIFont(name: Constants.textFormat, size: 13)!])
        artistName.attributedText = textAttribute
        artistName.adjustsFontSizeToFitWidth = true
        artistName.translatesAutoresizingMaskIntoConstraints = false
        return artistName
    }()
    
    private var arrowImage:UIImageView = {
        let arrowImage = UIImageView(frame: .zero)
        arrowImage.contentMode = .scaleToFill
        arrowImage.tintColor = .black
        arrowImage.image = UIImage(systemName: "arrow.right.circle")
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        return arrowImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with artistName:String, with imageUrl:String){
        DispatchQueue.main.async {
            self.artistName.text = artistName
            self.artistImage.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
    }
    
    
    private func setConstraints(){
        
        
        [artistImage, artistName, arrowImage].forEach {addSubview($0)}
        
        let constraintHeight = NSLayoutConstraint(item: artistImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        constraintHeight.priority = .defaultHigh + 1
        
        NSLayoutConstraint.activate([
    
            artistImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            artistImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            artistImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            artistImage.widthAnchor.constraint(equalToConstant: 60),
            artistName.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 10),
            artistName.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -5),
            artistName.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            arrowImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImage.widthAnchor.constraint(equalToConstant: 20),
            constraintHeight
        
        ])
        
        
    }
    
    
}
