//
//  NetworkManager.swift
//  firstParseApp
//
//  Created by PenguinRaja on 04.03.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRecipe(from url: String?, with complition: @escaping (Recipe) -> ()) {
        
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
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
    
    func fetchRecipeDetail(from url: String?, with complition: @escaping (RecipeInfo) -> ()){
        
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let recipeInfo = try JSONDecoder().decode(RecipeInfo.self, from: data)
                DispatchQueue.main.async {
                    complition(recipeInfo)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func alamofireFetchRecipe(from url: String?, with complition: @escaping (Recipe) -> ()) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        AF.request(url)
            .responseDecodable(of: Recipe.self) { responseData in
                switch responseData.result {
                case .success(let value):
                    complition(value)
                case .failure(let error):
                    print(error)
                }
        }
    }

}
