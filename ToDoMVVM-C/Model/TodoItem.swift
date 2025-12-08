//
//  TodoItem.swift
//  ToDoMVVM-C
//
//  Created by Enzo Henrique Botelho Romão on 08/12/25.
//

import Foundation

struct TodoItem: Identifiable {
    let id: UUID = UUID()
    var title: String
    var isCompleted: Bool = false
    
    mutating func toggleCompletion() {
        isCompleted.toggle()
    }
}

