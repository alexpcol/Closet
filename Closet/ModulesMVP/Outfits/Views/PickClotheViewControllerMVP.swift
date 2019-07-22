//
//  PickClotheViewControllerMVP.swift
//  Closet
//
//  Created by Chila 7/2/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class PickClotheViewControllerMVP: UIViewController, Storyboarded, PickClotheViewable {
    @IBOutlet weak var clothesCollection: UICollectionView!
    private var presenter: PickClothePresentable!
    private var clothes = [Clothe]()
    
    override func viewDidLoad() {
        clothesCollection.dataSource = self
        clothesCollection.delegate = self
        clothesCollection.register(UINib(nibName: ClotheCell.nibName, bundle: nil), forCellWithReuseIdentifier: ClotheCell.identifier)
        presenter.fetchClothes()
    }
    
    func show(clothes: [Clothe]) {
        self.clothes = clothes
        clothesCollection.reloadData()
    }
    
    func setup(title: String, presenter: PickClothePresentable) {
        self.title = title
        self.presenter = presenter
    }
    
    func showCloseButton() {
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: presenter, action: #selector(presenter.cancel))
        navigationItem.leftBarButtonItems = [cancel]
    }
}

extension PickClotheViewControllerMVP: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectOption(index: indexPath.row)
    }
    
}

extension PickClotheViewControllerMVP: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClotheCell.identifier, for: indexPath) as! ClotheCell
        cell.setup(clothe: clothes[indexPath.row])
        return cell
    }
}

extension PickClotheViewControllerMVP: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
}
