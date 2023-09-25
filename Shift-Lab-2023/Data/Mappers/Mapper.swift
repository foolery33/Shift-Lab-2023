//
//  Mapper.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

protocol Mapper {
  associatedtype Response
  associatedtype Domain

  func call(_ response: Response) -> Domain
}
