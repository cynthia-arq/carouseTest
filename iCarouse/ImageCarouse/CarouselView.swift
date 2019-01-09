//
//  CarouselView.swift
//  Allianz_Centre
//
//  Created by cynthia fu on 8/1/19.
//

import Foundation
import UIKit

struct CarouselViewPresentationItem {
    let cellItems: [ImageCarouselCellPresentationItem]
}

final class CarouselView: UIView, ViewWithNib, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    typealias CarouselViewCellPresentationItem = ImageCarouselCellPresentationItem
    
    typealias CarouselViewCell = ImageCarouselCell
    
    //private let configuration: CarouselViewConfiguration
    
    private let pagingInset: CGFloat = 0
    
    @IBOutlet weak var caroucelCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    /// The carousel data provider.
    var cellItems: [CarouselViewCellPresentationItem] = [] {
        didSet {
            reloadData()
        }
    }
  
    // MARK: - Properties
    
    /// The currently focused item
//    private(set) var currentItem: Int = 0
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    convenience init(cellItems: [CarouselViewCellPresentationItem]) {
//        self.cellItems = cellItems
//    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
        self.pageControl.numberOfPages = 0
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        super.awakeAfter(using: aDecoder)
        if subviews.count == 0 {
            let carouselView = CarouselView.loadFromNib()
            carouselView.translatesAutoresizingMaskIntoConstraints = false
            return carouselView
        }
        return self
    }
    
    /// Will reload the carousel data
    func reloadData() {
        registerCells()
//        guard dataSource != nil else {
//            collectionView.contentInset = .zero
//            return
//        }
        self.pageControl.numberOfPages = cellItems.count
        caroucelCollectionView.reloadData()
        //updateInsetsForCurrentSettings()
        setNeedsLayout()
    }
    
    private func configureCollectionView() {
        registerCells()
        (caroucelCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        
        caroucelCollectionView.contentInset = UIEdgeInsets(top: 0, left: pagingInset, bottom: 0, right: pagingInset)
        caroucelCollectionView.showsHorizontalScrollIndicator = false
        caroucelCollectionView.showsVerticalScrollIndicator = false
        caroucelCollectionView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.7)
        
    }
    
//    func configureForPresentationItem(_ item: CarouselViewPresentationItem) {
////        tagLabel.text = item.tag
////        titleLabel.text = item.title
////        subtitleLabel.text = item.subtitle
////        backgroundImageView.loadImageUsingCache(withUrl: item.imageURL, showActivity: false)
//        //self.dataSource = dataSource
//        applyStyle()
//    }
//    func applyStyle() {
//        //Add style for display
//    }
    
    private func registerCells() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ImageCarouselCell", bundle: bundle)
        caroucelCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: CarouselViewCell.self))
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CarouselViewCell.self), for: indexPath) as? CarouselViewCell else {
            return UICollectionViewCell()
        }
        cell.configureForPresentationItem(cellItems[indexPath.item])
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let swipeVelocityThreshold: CGFloat = 0.3
//        let targetOffset = targetContentOffset.pointee
//        let cellWidth = caroucelCollectionView.bounds.width - 2 * pagingInset
//        // adjusted offset with the cell snap to the center of the collection view
//        var adjustedOffset = CGPoint(x: (targetOffset.x - targetOffset.x.remainder(dividingBy: cellWidth) - pagingInset), y: targetOffset.y)
//        if 0 < abs(velocity.x) && abs(velocity.x) < swipeVelocityThreshold {
//            // slowly swipe
//            if (adjustedOffset.x - targetOffset.x) * velocity.x > 0 {
//                // swipe direction same as snap direction
//                targetContentOffset.pointee = adjustedOffset
//                return
//            }
//        } else if abs(velocity.x) >= swipeVelocityThreshold {
//            // when swip speed is fast
//            if abs(adjustedOffset.x - caroucelCollectionView.contentOffset.x) < cellWidth {
//                // when the scrolling speed not enough, skip to the next cell
//                adjustedOffset = CGPoint(x: (adjustedOffset.x + cellWidth * velocity.x / abs(velocity.x)), y: adjustedOffset.y)
//            }
//            targetContentOffset.pointee = adjustedOffset
//            return
//        }
//        // snap back to place
//        let indexPath = IndexPath(item: itemIndexforContentOffset(targetOffset), section: 0)
//        targetContentOffset.pointee = caroucelCollectionView.contentOffset
//        caroucelCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
//    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 2 * pagingInset, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - private helper
    private func itemIndexforContentOffset(_ offset: CGPoint) -> Int {
        let cellWidth = caroucelCollectionView.bounds.width - 2 * pagingInset
        let proportionalOffset = offset.x / cellWidth
        let index = Int(round(proportionalOffset))
        let numberOfItems = caroucelCollectionView.numberOfItems(inSection: 0)
        let safeIndex = max(0, min(numberOfItems - 1, index))
        return safeIndex
    }
}
