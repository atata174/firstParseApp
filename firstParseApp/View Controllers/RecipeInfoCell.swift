//
//  RecipeInfoCell.swift
//  firstParseApp
//
//  Created by PenguinRaja on 03.03.2021.
//

import UIKit

class RecipeInfoCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var labelBG: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let apiKey = "?apiKey=9639391a2eab40f3b485bfe0c1196c51"
    
    func configure(with recipe: Recipe?) {
        nameLabel.text = recipe?.recipes.first?.title
        DispatchQueue.global().async {
            guard let stringUrl = recipe?.recipes.first?.image else { return }
            guard let imageUrl = URL(string: stringUrl + self.apiKey) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
}
