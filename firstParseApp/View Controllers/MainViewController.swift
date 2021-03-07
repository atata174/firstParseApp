//
//  MainViewController.swift
//  firstParseApp
//
//  Created by PenguinRaja on 02.03.2021.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    @IBOutlet var randomButton: UIButton!
    
    private let apiKey = "apiKey=9639391a2eab40f3b485bfe0c1196c51"
    
    var recipeModel: Recipe?

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let randomVC = segue.destination as? RandomViewController else { return }
        let recipe = recipeModel?.recipes.first
        randomVC.recipe = recipe
    }
    
    @IBAction func randomButtonAction() {
        
        fetchRecipe(from: "https://api.spoonacular.com/recipes/random?\(apiKey)")

        while recipeModel != nil {
            performSegue(withIdentifier: "randomRecipeSegue", sender: nil)
            break
        }
    }
    
    private func fetchRecipe(from url: String?) {
        DispatchQueue.main.async {
            NetworkManager.shared.alamofireFetchRecipe(from: url) { recipe in
                self.recipeModel = recipe
            }
        }
    }
}
