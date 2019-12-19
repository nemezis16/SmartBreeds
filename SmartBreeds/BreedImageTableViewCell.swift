//
//  BreedImageTableViewCell.swift
//  SmartBreeds
//
//  Created by Roman Osadchuk on 19.12.2019.
//  Copyright © 2019 Roman Osadchuk. All rights reserved.
//

import UIKit

class BreedImageTableViewCell: UITableViewCell {

    @IBOutlet var breedImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()

        breedImageView.image = nil
    }

}
