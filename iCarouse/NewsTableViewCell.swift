//
//  NewsTableViewCell.swift
//  iCarouse
//
//  Created by Fu Qian on 9/1/19.
//  Copyright © 2019 Fu Qian. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var carouselView: CarouselView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //var cellItems: [CarouselViewCellPresentationItem] = []
    //CarouselViewCellPresentationItem
    func configureCell(fromNews news: News) {
       
        if let imageURLs = news.imageURLs, imageURLs.count > 0 {
            var cellItems: [ImageCarouselCellPresentationItem] = []
            for url in imageURLs {
                let item = ImageCarouselCellPresentationItem(imageURL: url)
                cellItems.append(item)
            }
            carouselView.cellItems = cellItems
        }
        
        
        
        titleLabel.text = news.name
        
//        else {
//            newsImageView.backgroundColor = UIColor.red
//            //newsImageView.loadImageUsingCache(withUrl: news.imageURL, showActivity: true)
//        }
    }
    
}
