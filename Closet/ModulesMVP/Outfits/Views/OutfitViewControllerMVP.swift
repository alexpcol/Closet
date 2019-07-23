//
//  OutfitsViewControllerMVP.swift
//  Closet
//
//  Created by Chila on 7/2/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class OutfitViewControllerMVP: UIViewController, Storyboarded, OutfitViewable {
    
    @IBOutlet weak var outfitsTable: UITableView!
    private var presenter: OutfitPresentable!
    private var outfits = [Outfit]()
    private var addButtonAction:(() -> Void)?
    
    override func viewDidLoad() {
        outfitsTable.dataSource = self
        outfitsTable.delegate = self
        //presenter.fetchClothes()
        presenter.fetchOutfits()
    }
    
    func showAddButton(action: @escaping () -> Void) {
        addButtonAction = action
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItems = [addButtonItem]
    }
    
    func setup(title: String, presenter: OutfitPresentable) {
        self.title = title
        self.presenter = presenter
    }
    
    func setSection(icon: String, title: String) {
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(named: icon), tag: 0)
    }
    
    func show(outfits: [Outfit]) {
        self.outfits = outfits
        if let table = outfitsTable {
            table.reloadData()
        }
    }
    
    //MARK:- Actions
    @objc private func didTapAddButton() {
        addButtonAction?()
    }

}

extension OutfitViewControllerMVP: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension OutfitViewControllerMVP: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outfits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.text = outfits[indexPath.row].name
        return cell
    }
}
