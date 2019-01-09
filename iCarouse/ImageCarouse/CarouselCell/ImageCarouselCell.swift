//
//  ImageCarouselCell.swift
//  Allianz_Centre
//
//  Created by cynthia fu on 8/1/19.
//

import UIKit

struct ImageCarouselCellPresentationItem {
    let imageURL: String
    
    init(imageURL: String) {
        self.imageURL = imageURL
    }
}

class ImageCarouselCell: UICollectionViewCell {

    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureForPresentationItem(_ item: ImageCarouselCellPresentationItem) {
        //backgroundImageView.loadImageUsingCache(withUrl: item.imageURL, showActivity: false)
        urlLabel.text = item.imageURL
        applyStyle()
    }
    
    func applyStyle() {
    }

}
