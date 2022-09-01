//
//  TodoView.swift
//  SwiftUICleanArchitecture
//
//  Created by Lucy on 01/09/22.
//

import SwiftUI

struct TodoView: View {
    @StateObject var viewModel = TodoViewModel()

    var body: some View {
        NavigationView{
            List{
                viewModel.todos.isEmpty ? Text("Loading...").padding() : nil
                
                ForEach(viewModel.todos){ todo in
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
