//
//  HomeViewModel.swift
//  ToDoMVVM-C
//
//  Created by Enzo Henrique Botelho Romão on 08/12/25.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didUpdateItems()
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    weak var coordinator: HomeCoordinator?
    
    private(set) var items: [TodoItem] = [] {
        didSet {
            delegate?.didUpdateItems()
        }
    }
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Funções de Lógica de Dados
    
    func toggleTask(at index: Int) {
        items[index].toggleCompletion()
    }
    
    func deleteTask(at index: Int) {
        items.remove(at: index)
    }
    
    func addNewTask(title: String) {
        let newItem = TodoItem(title: title)
        items.append(newItem)
    }
    
    // MARK: - Funções de Navegação (chamam o Coordinator)
    
    func didTapPlusButton(modalDelegate: ModalVCDelegate) {
        coordinator?.goToAddTaskModal(delegate: modalDelegate)
    }
}
