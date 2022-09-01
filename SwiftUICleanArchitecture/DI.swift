//
//  Depedency.swift
//  SwiftUICleanArchitecture
//
//  Created by Lucy on 01/09/22.
//

import Foundation

class InitDepedencyInjection{
    init(){
        @Provider var todoDataSource = TodoAPIImpl() as ITodoDataSource
        @Provider var todoRepository = TodoRepositoryImpl(dataSource: todoDataSource) as ITodoRepository
    }
}
