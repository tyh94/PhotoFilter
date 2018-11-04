//
//  FilterViewController.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class FilterViewController: UIViewController, FilterViewInput, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var viewOutput: FilterViewOutput!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UPCarouselFlowLayout!
    
    var cellObjects = [FilterCollectionViewCellObject]()
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(shareTapped))
    }
    
    private func configureCollectionView() {
        flowLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
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
    
    // MARK: FilterViewInput
    
    func setup(image: UIImage) {
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
        cell.bindViewModel(cellObjects[indexPath.item])
        viewOutput.getImage(index: indexPath.item) { (image) -> (Void) in
            cell.imageView.image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? FilterCollectionViewCell {
            viewOutput.getImage(index: indexPath.item) { (image) -> (Void) in
                cell.imageView.image = image
            }
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = cellObjects[indexPath.item]
        viewOutput.didSelect(object: object)
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSide = layout.itemSize.width
        pageSide += layout.minimumLineSpacing
        let offset = scrollView.contentOffset.x
        let currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView(collectionView, didSelectItemAt: indexPath)
    }
}
