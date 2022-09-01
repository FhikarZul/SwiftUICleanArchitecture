//
//  GetTodos.swift
//  SwiftUICleanArchitecture
//
//  Created by Lucy on 01/09/22.
//

import Foundation

enum UseCaseError: Error{
    case networkError, decodingError
}

protocol GetTodos{
    func execute() async -> Result<[Todo], UseCaseError>
}

struct GetTodosUseCase: GetTodos{
    var repository: ITodoRepository
    
    func execute() async -> Result<[Todo], UseCaseError> {
        do{
            let todos = try await repository.getTodos()
            
            return .success(todos)
        }catch(let error){
            
            switch error {
            case UseCaseError.networkError:
                return .failure(.networkError)
                
            default:
                return .failure(.decodingError)
            }
            
        }
    }
}
