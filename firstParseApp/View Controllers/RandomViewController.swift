//
//  RandomViewController.swift
//  firstParseApp
//
//  Created by PenguinRaja on 02.03.2021.
//

import UIKit

private let reuseIdentifier = "cell"

class RandomViewController: UICollectionViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var countRandomRecipes: Int!
    var recipe: Recipe?

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipe?.recipes.count ?? 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RecipeInfoCell else { return UICollectionViewCell() }
        
        cell.nameLabel.text = recipe?.recipes.first?.title
        cell.configure(with: recipe)

        return cell
    }
    
    private func fetchImage() {
        
    }
}

extension RandomViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
