//
//  TodoAPIEntity.swift
//  SwiftUICleanArchitecture
//
//  Created by Lucy on 01/09/22.
//

import Foundation

struct TodoAPIEntity: Codable{
    let id: Int
    let title: String
    let completed: Bool
}
