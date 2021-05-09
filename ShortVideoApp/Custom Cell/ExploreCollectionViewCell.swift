//
//  ExploreCollectionViewCell.swift
//  ShortVideoApp
//
//  Created by Biswajyoti Sahu on 07/05/21.
//

import UIKit
import AVKit

class ExploreCollectionViewCell: UICollectionViewCell {

    let exploreImage: UIImageView
    var sectionIndex: Int = 0
    var itemIndex: Int = 0
    var imageCache = NSCache<NSString, UIImage>()
    
    override init(frame: CGRect) {
        
        exploreImage = UIImageView()
        exploreImage.clipsToBounds = true
        exploreImage.layer.cornerRadius = 10.0
        exploreImage.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        contentView.addSubview(exploreImage)
        addCustomConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillData(_ node: Node, indexPath: IndexPath) {
        
        let encodeUrl = node.video.encodeUrl
        if let url = URL(string: encodeUrl) {
            
            if let cachedImage = imageCache.object(forKey: encodeUrl as NSString) {
                
                exploreImage.image = cachedImage
                return
            }
            exploreImage.image = UIImage(named: "placeholder")

            AVAsset(url: url).generateThumbnail { [weak self] (image) in
                
                guard let self = self else {return}
                DispatchQueue.main.async {
                    
                    if self.sectionIndex == indexPath.section
                        && self.itemIndex == indexPath.item, let thumbnailImage = image {
                        
                        self.imageCache.setObject(thumbnailImage, forKey: encodeUrl as NSString)
                        self.exploreImage.image = thumbnailImage
                    }
                }
            }
            
        }
        
    }
    
    private func addCustomConstraints() {
        
        NSLayoutConstraint.activate([
            
            exploreImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            exploreImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            exploreImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            exploreImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
