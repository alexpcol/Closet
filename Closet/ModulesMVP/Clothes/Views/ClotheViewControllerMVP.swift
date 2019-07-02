//
//  ClotheViewControllerMVP.swift
//  Closet
//
//  Created by chila on 6/29/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class ClotheViewControllerMVP: UIViewController, ClotheViewable, Storyboarded {
    @IBOutlet weak var clothesCollection: UICollectionView!
    private var clothes = [Clothe]()
    private var presenter: ClothePresentable!
    private var addButtonAction:(() -> Void)?
    
    override func viewDidLoad() {
        clothesCollection.dataSource = self
        clothesCollection.delegate = self
        clothesCollection.register(UINib(nibName: ClotheCell.nibName, bundle: nil), forCellWithReuseIdentifier: ClotheCell.identifier)
        presenter.fetchClothes()
    }
    
    func showAddButton(action: @escaping () -> Void) {
        addButtonAction = action
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItems = [addButtonItem]
    }
    
    func setup(title: String, presenter: ClothePresentable) {
        self.title = title
        self.presenter = presenter
    }
    
    func setSection(icon: String, title: String) {
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(named: icon), tag: 0)
    }
    
    func show(clothes: [Clothe]) {
        self.clothes = clothes
        clothesCollection.reloadData()
    }
    
    //MARK:- Actions
    @objc private func didTapAddButton() {
        addButtonAction?()
    }
}

extension ClotheViewControllerMVP: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClotheCell.identifier, for: indexPath) as! ClotheCell
        cell.setup(clothe: clothes[indexPath.row])
        return cell
    }
}

extension ClotheViewControllerMVP: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
}
