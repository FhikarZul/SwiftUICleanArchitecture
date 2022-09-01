//
//  TodoAPIImpl.swift
//  SwiftUICleanArchitecture
//
//  Created by Lucy on 01/09/22.
//

import Foundation

enum APIServiceError: Error{
    case badUrl, requestError, decodingError, statusNotOk
}

struct TodoAPIImpl: ITodoDataSource{
    func getTodos() async throws -> [Todo] {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else{
            throw APIServiceError.badUrl
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else{
            throw APIServiceError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw APIServiceError.statusNotOk
        }
        
        guard let result = try? JSONDecoder().decode([TodoAPIEntity].self, from: data) else{
            throw APIServiceError.decodingError
        }
        
        return result.map{ item in
            Todo(
                id: item.id,
                title: item.title,
                isCompleted: item.completed
            )
        }
    }
    
    
}
