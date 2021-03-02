//
//  Recipe.swift
//  firstParseApp
//
//  Created by PenguinRaja on 01.03.2021.
//

struct RecipeRandom {
    let id: Int
    let image: String
    let title: String
    
}

struct RecipeInfo {
    let id: Int
    let title: String
    let image: String
    let extendedIngredients: [extendedIngredient]
}

struct extendedIngredient {
    let id: Int
    let name: String
    let image: String
    let amount: Float
}
