//
//  RecipeInformationViewController.swift
//  firstParseApp
//
//  Created by PenguinRaja on 02.03.2021.
//

import UIKit

class RecipeInformationViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate, UITableViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    let screenHeight = UIScreen.main.bounds.height
    let scrollViewContentHeight = 1200 as CGFloat
    var recipe: Recipe!
    let scrollViewContentWidth = CGFloat(UIScreen.main.bounds.width)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = recipe.recipes.first?.title ?? "Recipe Info"
        
//        scrollView.contentSize = CGSizeMake(scrollViewContentWidth, scrollViewContentHeight)
        scrollView.delegate = self
        tableView.delegate = self
        scrollView.bounces = false
        tableView.bounces = false
        tableView.isScrollEnabled = true
        scrollView.isScrollEnabled = true
    }
    
    //MARK: - TableView Datasourse
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Ingredients"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipe.recipes.first?.extendedIngredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RecipeInfoTableViewCell
        
        let recipeCell = recipe.recipes.first?.extendedIngredients[indexPath.row]
        cell?.descriptionLabel.text = recipeCell?.description
        
        return cell ?? UITableViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y

        if scrollView == self.scrollView {
            if yOffset >= scrollViewContentHeight - screenHeight {
                scrollView.isScrollEnabled = false
                tableView.isScrollEnabled = true
            }
        }

        if scrollView == self.tableView {
            if yOffset <= 0 {
                self.scrollView.isScrollEnabled = true
                self.tableView.isScrollEnabled = false
            }
        }
    }
}
