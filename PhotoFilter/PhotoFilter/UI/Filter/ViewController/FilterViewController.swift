//
//  FilterViewController.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit
import IGListKit

class FilterViewController: UIViewController, FilterViewInput, ListAdapterDataSource, ListSingleSectionControllerDelegate {
    
    var viewOutput: FilterViewOutput!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var adapter: ListAdapter!
    var cellObjects = [FilterCollectionViewCellObject]()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("FILTER_NAVIGATION_TITLE", comment: "")
        configureCollectionView()
        viewOutput.moduleWasLoaded()
    }
    
    // MARK: Private
    
    private func configureCollectionView() {
        let idenitfier = String(describing: FilterCollectionViewCell.self)
        let nib = UINib(nibName: idenitfier,
                        bundle: Bundle.init(for: FilterCollectionViewCell.self))
        collectionView.register(nib,
                                forCellWithReuseIdentifier: idenitfier)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    // MARK: FilterViewInput
    
    func setup(image: UIImage) {
        imageView.image = image
    }
    
    func update(cellObjects: [FilterCollectionViewCellObject]) {
        self.cellObjects = cellObjects
        adapter.reloadData(completion: nil)
    }
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return cellObjects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let section =  ListSingleSectionController(nibName: String(describing: FilterCollectionViewCell.self),
                                                   bundle: nil,
                                                   configureBlock: { (cellObject, cell) in
                                                    if let cell = cell as? FilterCollectionViewCell {
                                                        cell.bindViewModel(cellObject)
                                                    }
                                                    
        }) { (cellObject, contect) -> CGSize in
            return CGSize(width: 150, height: 150)
        }
        section.selectionDelegate = self
        return section
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    // MARK: ListSingleSectionControllerDelegate
    
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        if let object = object as? FilterCollectionViewCellObject {
            viewOutput.didSelect(object: object)
        }
    }
}
