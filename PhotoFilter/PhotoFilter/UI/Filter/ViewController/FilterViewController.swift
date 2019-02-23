//
//  FilterViewController.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class FilterViewController: UIViewController, FilterViewInput, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var viewOutput: FilterViewOutput!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UPCarouselFlowLayout!
    
    var cellObjects = [FilterCollectionViewCellObject]()
    
    var lastPoint = CGPoint.zero
    var lastScale = CGFloat(1.0)
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionView()
        viewOutput.moduleWasLoaded()
    }
    
    // MARK: Private
    
    private func configureNavigationBar() {
        title = NSLocalizedString("FILTER_NAVIGATION_TITLE", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("SHARE_BUTTON_TITLE",
                                                                                     comment: ""),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(shareTapped))
    }
    
    private func configureCollectionView() {
        flowLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: 10)
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150, height: 150)
        let idenitfier = String(describing: FilterCollectionViewCell.self)
        let nib = UINib(nibName: idenitfier,
                        bundle: Bundle.init(for: FilterCollectionViewCell.self))
        collectionView.register(nib,
                                forCellWithReuseIdentifier: idenitfier)
    }
    
    @objc private func shareTapped() {
        viewOutput.shareCurrentImage(barButtonItem: navigationItem.rightBarButtonItem!)
    }
    
    func setImageToCrop(image: UIImage){
        imageView.image = image
        imageViewWidth.constant = image.size.width
        imageViewHeight.constant = image.size.height
        let scaleHeight = scrollView.frame.size.width/image.size.width
        let scaleWidth = scrollView.frame.size.height/image.size.height
        let maxScale = max(scaleWidth, scaleHeight)
        scrollView.minimumZoomScale = maxScale
        scrollView.zoomScale = maxScale
    }
    
    func croppedImageRect() -> CGRect {
        let scale = 1 / scrollView.zoomScale
        let x = scrollView.contentOffset.x * scale
        let y = scrollView.contentOffset.y * scale
        let width = scrollView.frame.size.width * scale
        let height = scrollView.frame.size.height * scale
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    // MARK: FilterViewInput
    
    func setup(image: UIImage) {
        setImageToCrop(image: image)
    }
    
    func update(image: UIImage) {
        imageView.image = image
    }
    
    func update(cellObjects: [FilterCollectionViewCellObject]) {
        self.cellObjects = cellObjects
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FilterCollectionViewCell.self), for: indexPath) as! FilterCollectionViewCell
        let cellObject = cellObjects[indexPath.item]
        cell.bindViewModel(cellObject)
        if (cellObject.image == nil) {
            viewOutput.getImage(index: indexPath.item) { (image) -> (Void) in
                cell.imageView.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? FilterCollectionViewCell {
            let cellObject = cellObjects[indexPath.item]
            if (cellObject.image == nil) {
                viewOutput.getImage(index: indexPath.item) { (image) -> (Void) in
                    cell.imageView.image = image
                }
            }
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < cellObjects.count && indexPath.item >= 0 {
            let object = cellObjects[indexPath.item]
            viewOutput.didSelect(object: object)
            collectionView.scrollToItem(at: indexPath,
                                        at: UICollectionView.ScrollPosition.centeredHorizontally,
                                        animated: true)
        }
    }

}

// MARK: UIScrollViewDelegate
extension FilterViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if scrollView == self.scrollView {
            return imageView
        }
        return nil
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView { return }
        let layout = collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSide = layout.itemSize.width
        pageSide += layout.minimumLineSpacing
        let offset = scrollView.contentOffset.x
        let currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
}
