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
    private var viewModel: OutfitViewModel!
    
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
        setViewModelProperties()
    }
    
    private func setViewModelProperties() {
        viewModel.outfits.bindAndFire { [unowned self] (_) in
            self.outfitsTable.reloadData()
        }
    }
    
    //MARK:- Actions & Selectors
    @objc private func addOutfit() {
        coordinator?.addOutfit()
    }
}

extension OutfitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension OutfitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outfits.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        viewModel.outfitCellModel[indexPath.row].congifure(cell)
        return cell
    }
}
