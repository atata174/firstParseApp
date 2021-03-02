//
//  Ingredient.swift
//  firstParseApp
//
//  Created by PenguinRaja on 02.03.2021.
//

struct Ingredient {
    let id: Int
    let name: String
    let image: String
    let categoryPath: [String]
    let estimatedCost: [EstimatedCost]
}

struct EstimatedCost {
    let value: Float
    let unit: String
}
