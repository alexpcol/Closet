//
//  PickClothePieceTypeViewController.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

protocol ClothePicked: class {
    func didSelectClothe(_ clothe: Clothe)
}

class PickClothePieceTypeViewController: UIViewController, Storyboarded {
    weak var delegate: ClothePicked?
    @IBOutlet private weak var clothesCollection: UICollectionView!
    private var viewModel: PickClothePieceTypeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func setupView(viewModel: PickClothePieceTypeViewModel) {
        self.viewModel = viewModel
    }
    
    private func initialize() {
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        navigationItem.leftBarButtonItems = [cancel]
        clothesCollection.dataSource = self
        clothesCollection.delegate = self
        clothesCollection.register(UINib(nibName: ClotheCell.nibName, bundle: nil), forCellWithReuseIdentifier: ClotheCell.identifier)
    }
    
    @objc private func close() {
        self.dismiss(animated: true)
    }
}

extension PickClothePieceTypeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectClothe(viewModel.clothes[indexPath.row])
        close()
    }
}

extension PickClothePieceTypeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.clothes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClotheCell.identifier, for: indexPath) as! ClotheCell
        
        viewModel.clotheCellModel[indexPath.row].congifure(cell)
        return cell
    }
}

extension PickClothePieceTypeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
}
