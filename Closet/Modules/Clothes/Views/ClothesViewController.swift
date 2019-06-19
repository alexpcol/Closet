//
//  ClothesViewController.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class ClothesViewController: UIViewController, Storyboarded {
    
    @IBOutlet private weak var clothesCollection: UICollectionView!
    private var viewModel: ClotheViewModel?
    weak var coordinator: ClothesCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func setupView(viewModel: ClotheViewModel) {
        // Configuración inicial al momento de crear la instnacia
        self.viewModel = viewModel
    }
    
    private func initialize() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addClothe))
        navigationItem.rightBarButtonItems = [addButtonItem]
        clothesCollection.dataSource = self
        clothesCollection.delegate = self
        clothesCollection.register(UINib(nibName: ClotheCell.nibName, bundle: nil), forCellWithReuseIdentifier: ClotheCell.identifier)
        subscribeNotifications()
    }
    
    private func subscribeNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveNotification(_:)),
                                               name: .CoreDataDidSavedClothe,
                                               object: nil)
    }
    
    private func refreshClotheCollection() {
        viewModel?.refreshFromDatabase()
        clothesCollection.reloadData()
    }
    
    //MARK:- Actions & Selectors
    @objc private func addClothe() {
        viewModel?.dumbAddClothe()
    }
    
    @objc private func didReceiveNotification(_ notification: Notification) {
        guard let isSaved = notification.userInfo?["saved"] as? Bool else { return }
        if isSaved {
            refreshClotheCollection()
        }
    }
}

extension ClothesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.clothes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClotheCell.identifier, for: indexPath) as! ClotheCell
        
        viewModel?.clotheCellModel[indexPath.row].congifure(cell)
        return cell
    }
}

extension ClothesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
}
