//
//  Indgredient.swift
//  Ethanol
//
//  Created by Ireneusz Sołek on 07/11/2020.
//

import Foundation

struct Ingredient {
  let id: String
  let unit: Unit
  let amount: Int
  
  var name: String { id }
}
