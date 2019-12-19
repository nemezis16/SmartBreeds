//
//  BreedItemTableViewCell.swift
//  SmartBreeds
//
//  Created by Roman Osadchuk on 19.12.2019.
//  Copyright © 2019 Roman Osadchuk. All rights reserved.
//

import UIKit

class BreedItemTableViewCell: UITableViewCell {

    @IBOutlet weak var breedName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        breedName.text = ""
    }

}
