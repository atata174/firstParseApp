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
        fetchRecipeImage()
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
        content.text = recipeCell.name
        content.secondaryText = String(recipeCell.amount)
        
        return cell
    }
    
    private func fetchRecipeImage(){
        guard let imageURL = URL(string: "https://spoonacular.com/recipeImages/\(recipe.id)-240x150.jpg") else { return }
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            if let response = response {
                print(response)
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
    

}

extension RecipeInformationViewController: UICollectionViewDelegate {
    
}
