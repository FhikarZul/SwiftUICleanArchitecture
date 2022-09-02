//
//  TodoView.swift
//  SwiftUICleanArchitecture
//
//  Created by Lucy on 01/09/22.
//

import SwiftUI

struct TodoView: View {
    @StateObject private var viewModel = TodoViewModel()
    
    @State var searchText: String = ""
    
    var filteredTodos: [Todo] {
        if searchText.isEmpty {
            return viewModel.todos
        } else {
            return viewModel.todos.filter{ $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView{
            List{
                viewModel.todos.isEmpty ? Text("Loading...").padding() : nil
                (filteredTodos.isEmpty && searchText != "") ? Text("Not Result").padding() : nil
                
                ForEach(filteredTodos){ todo in
                    VStack(alignment: .leading){
                        HStack{
                            VStack(alignment: .leading){
                                Text(todo.title)
                                Text(String(todo.isCompleted))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: todo.isCompleted ? "checkmark.circle" : "circle")
                                .foregroundColor(todo.isCompleted ? .green : .red)
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search Todos")
            .task {
                await viewModel.getTodos()
            }
            .alert("Error", isPresented: $viewModel.hasError){
                
            } message: {
                Text(viewModel.errorMessage)
            }
            .navigationTitle("Todo List")
            .toolbar{
                    ToolbarItem{
                        Button("Refresh"){
                            Task{
                                await viewModel.getTodos()
                            }
                        }
                }
            }
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
