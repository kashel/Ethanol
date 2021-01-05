//
//  Unit.swift
//  Ethanol
//
//  Created by Ireneusz Sołek on 07/11/2020.
//

import Foundation

enum Unit {
  case gram
  case ml
  case piece
  case other(name: String)
  
  var displayName: String {
    switch self {
    case .gram:
      return "gram"
    case .ml:
      return "ml"
    case .piece:
      return "pice"
    case .other(let name):
      return name
    }
  }
}
