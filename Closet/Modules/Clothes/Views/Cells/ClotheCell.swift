//
//  ClotheCell.swift
//  Closet
//
//  Created by chila on 6/15/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit

class ClotheCell: UICollectionViewCell {
    
    static var identifier = "clotheCellIdentifier"
    static var nibName = "ClotheCell"
    
    @IBOutlet weak var typeIcon: UIImageView!
    @IBOutlet weak var preview: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setup( ) {
        
    }

}
