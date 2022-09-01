//
//  TodoViewModel.swift
//  SwiftUICleanArchitecture
//
//  Created by Lucy on 01/09/22.
//

import Foundation

class TodoViewModel: ObservableObject{
    
    
    var getTodoUseCase: GetTodosUseCase
    
    @Published var todos: [Todo] = []
    @Published var errorMessage = ""
    @Published var hasError = false
    
    init(){
        @Inject var repository: ITodoRepository
        
        getTodoUseCase = GetTodosUseCase(repository: repository)
    }
    
    func getTodos() async {
        errorMessage = ""
        todos = []
        
        let result = await getTodoUseCase.execute()
        
        DispatchQueue.main.async {
            switch result {
                
            case .success(let todos):
                self.todos = todos
            case .failure(let error):
                self.todos = []
                self.errorMessage = error.localizedDescription
                self.hasError = true
                
            }
        }
    }
    
}
