//
//  Recipe.swift
//  firstParseApp
//
//  Created by PenguinRaja on 01.03.2021.
//

struct RecipeRandom: Decodable{
    let recipes: [RecipeInfo]
    
}

struct RecipeInfo: Decodable {
    let id: Int
    let title: String
    let image: String
    let extendedIngredients: [extendedIngredient]
}

struct extendedIngredient: Decodable {
    let id: Int
    let name: String
    let image: String
    let amount: Float
}


