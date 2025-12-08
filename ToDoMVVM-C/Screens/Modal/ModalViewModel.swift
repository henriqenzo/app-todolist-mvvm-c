//
//  ModalViewModel.swift
//  ToDoMVVM-C
//
//  Created by Enzo Henrique Botelho Romão on 08/12/25.
//

import Foundation

class ModalViewModel {
    
    weak var coordinator: HomeCoordinator?
    
    private(set) var itemTitle: String = ""
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func updateItemTitle(text: String?) {
        itemTitle = text ?? ""
    }
    
    func canAddNewTask() -> Bool {
        return !itemTitle.isEmpty
    }
    
    func didFinish() {
        coordinator?.modalDidFinish()
    }
}
