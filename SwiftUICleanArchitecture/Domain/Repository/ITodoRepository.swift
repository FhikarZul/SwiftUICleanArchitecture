//
//  TodoRepository.swift
//  SwiftUICleanArchitecture
//
//  Created by Lucy on 01/09/22.
//

import Foundation

protocol ITodoRepository{
    func getTodos() async throws -> [Todo]
}
