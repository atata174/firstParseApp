//
//  RecipeInformationViewController.swift
//  firstParseApp
//
//  Created by PenguinRaja on 02.03.2021.
//

import UIKit

class RecipeInformationViewController: UIViewController {
    
    var recipe: RecipeInfo?

    @IBOutlet var imageRecipe: UIImageView!
    @IBOutlet var recipeDetailLabel: UILabel!
    @IBOutlet var ingredientsLabel: UILabel!
    private var fullIngredients = ""
    private let apiKey = "?apiKey=9639391a2eab40f3b485bfe0c1196c51"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeDetailLabel.text = recipe?.description
        guard let count = recipe?.extendedIngredients.count else { return }
        guard let ingredient = recipe?.extendedIngredients else { return }
        
        for element in 0..<count {
            fullIngredients += "\(ingredient[element].description) \n"
        }
        
        ingredientsLabel.text = fullIngredients
        configure(with: recipe)
    }
    
    func configure(with recipe: RecipeInfo?) {
        DispatchQueue.global().async {
            guard let stringUrl = recipe?.image else { return }
            guard let imageUrl = URL(string: stringUrl + self.apiKey) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.imageRecipe.image = UIImage(data: imageData)
            }
        }
    }
    
}
