//
//  RecipeInformationViewController.swift
//  firstParseApp
//
//  Created by PenguinRaja on 02.03.2021.
//

import UIKit

class RecipeInformationViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    var recipe: RecipeInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = recipe.title
    }
    
    //MARK: - TableView Datasourse
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Ingredients"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipe.extendedIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let recipeCell = recipe.extendedIngredients[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = recipeCell.originalName
        content.secondaryText = String(recipeCell.amount)
        
        return cell
    }
}
