//
//  MovieCell.swift
//  MoviesApplication
//
//  Created by Mehmet Baturay Yasar on 23/06/2022.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
    }

}
