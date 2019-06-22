//
//  OutfitViewController.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class OutfitViewController: UIViewController, Storyboarded {
    
    weak var coordinator: OutfitsCoordinator?
    @IBOutlet weak var outfitsTable: UITableView!
    private var viewModel: OutfitViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func setupView(viewModel: OutfitViewModel) {
        self.viewModel = viewModel
    }
    
    private func initialize() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addOutfit))
        navigationItem.rightBarButtonItems = [addButtonItem]
        outfitsTable.delegate = self
        outfitsTable.dataSource = self
        subscribeNotifications()
    }
    
    private func subscribeNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveNotification(_:)),
                                               name: .coreDataDidSavedOutfit,
                                               object: nil)
    }
    private func refreshClotheCollection() {
        viewModel?.refreshFromDatabase()
        outfitsTable.reloadData()
    }
    
    //MARK:- Actions & Selectors
    @objc private func addOutfit() {
        coordinator?.addOutfit()
    }
    @objc private func didReceiveNotification(_ notification: Notification) {
        guard let isSaved = notification.userInfo?["saved"] as? Bool else { return }
        if isSaved {
            refreshClotheCollection()
        }
    }
    
}

extension OutfitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension OutfitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.outfits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        viewModel?.outfitCellModel[indexPath.row].congifure(cell)
        return cell
    }
    
    
}
