//
//  Recipe.swift
//  firstParseApp
//
//  Created by PenguinRaja on 01.03.2021.
//

struct Recipe: Decodable{
    let recipes: [RecipeInfo]
}

struct RecipeInfo: Decodable {
    let title: String
    let image: String
    let readyInMinutes: Int
    let instructions: String
    let extendedIngredients: [extendedIngredient]
    
    var description: String {
        """
        Food name: \(title)
        Amount of ingredients: \(extendedIngredients.count)
        Time to cook: \(readyInMinutes) minutes
        Instructions: \(instructions)
        """
    }
}

struct extendedIngredient: Decodable {
    let originalName: String
    let image: String
    let amount: Float
    let unit: String
    
    var description: String {
        """
        \(originalName) - \(amount)\(unit)
        """
    }
}


