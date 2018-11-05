//
//  FilterViewController.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class FilterViewController: UIViewController, FilterViewInput, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    var viewOutput: FilterViewOutput!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UPCarouselFlowLayout!
    @IBOutlet weak var previewView: UIView!
    
    var cellObjects = [FilterCollectionViewCellObject]()
    
    var lastPoint = CGPoint.zero
    var lastScale = CGFloat(1.0)
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(panHandle(_:)))
        panGR.delegate = self
        previewView.addGestureRecognizer(panGR)
        let pinchGR = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandle(_:)))
        pinchGR.delegate = self
        previewView.addGestureRecognizer(pinchGR)
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
    
    // MARK: Gesture recognizers
    
    @IBAction func panHandle(_ sender: Any) {
        let gesture = sender as! UIPanGestureRecognizer
        switch gesture.state {
        case .began: do {
            lastPoint = gesture.location(in: imageView)
            }
            
        case .changed: do {
            var point = gesture.location(in: imageView)
            point.x -= lastPoint.x
            point.y -= lastPoint.y
            let playerTransform = imageView.layer.affineTransform()
            let transform = playerTransform.translatedBy(x: point.x, y: point.y)
            imageView.layer.setAffineTransform(transform)
            lastPoint = gesture.location(in: imageView)
            }
            
        case .ended, .failed, .cancelled: do {
            }
            
        default: break
        }
    }
    
    @IBAction func pinchHandle(_ sender: Any) {
        let gesture = sender as! UIPinchGestureRecognizer
        switch gesture.state {
        case .began: do {
            lastScale = gesture.scale
            }
            
        case .changed: do {
            let scale = gesture.scale / lastScale
            let playerTransform = imageView.layer.affineTransform()
            let transformScale = playerTransform.scaledBy(x: scale, y: scale)
            imageView.layer.setAffineTransform(transformScale)
            lastScale = gesture.scale
            }
            
        case .ended, .failed, .cancelled: do {
            }
            
        default: break
        }
    }
    
    // MARK: UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return ((gestureRecognizer is UIPanGestureRecognizer) &&
            (otherGestureRecognizer is UIPinchGestureRecognizer)) ||
            ((gestureRecognizer is UIPinchGestureRecognizer) &&
                (otherGestureRecognizer is UIPanGestureRecognizer))
    }
}
