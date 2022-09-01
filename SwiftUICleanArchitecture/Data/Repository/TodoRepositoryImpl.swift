//
//  TodoRepositoryImpl.swift
//  SwiftUICleanArchitecture
//
//  Created by Lucy on 01/09/22.
//

import Foundation

struct TodoRepositoryImpl: ITodoRepository{
    var dataSource: ITodoDataSource
    
    func getTodos() async throws -> [Todo] {
        let _todos = try await dataSource.getTodos()
        
        return _todos
    }
    
    
}
