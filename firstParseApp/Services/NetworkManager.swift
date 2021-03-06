//
//  NetworkManager.swift
//  firstParseApp
//
//  Created by PenguinRaja on 04.03.2021.
//

import Foundation

enum URLExamples: String {
    case getRandomRecipe = "https://api.spoonacular.com/recipes/random"
    case getIngredient = "https://api.spoonacular.com/food/ingredients/search"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRecipe(from url: String?, with complition: @escaping (Recipe) -> ()) {
        
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let recipe = try JSONDecoder().decode(Recipe.self, from: data)
                DispatchQueue.main.async {
                    complition(recipe)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

class ImageManager {
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil}
        return try? Data(contentsOf: imageURL)
    }
    
}
