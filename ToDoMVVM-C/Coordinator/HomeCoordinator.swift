//
//  HomeCoordinator.swift
//  ToDoMVVM-C
//
//  Created by Enzo Henrique Botelho Romão on 08/12/25.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var children: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let viewController = HomeViewController()
        
        viewController.viewModel = viewModel
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func goToAddTaskModal(delegate: ModalVCDelegate) {
        let modalViewModel = ModalViewModel(coordinator: self)
        let modalVC = ModalViewController()
        
        modalVC.viewModel = modalViewModel
        modalVC.delegate = delegate
        
        modalVC.modalPresentationStyle = .pageSheet
        let customDetentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
        let customDetent = UISheetPresentationController.Detent.custom(identifier: customDetentIdentifier) { context in
            return 280
        }
        modalVC.sheetPresentationController?.detents = [customDetent]
        
        navigationController.present(modalVC, animated: true)
    }
    
    func modalDidFinish() {
        // Aqui limparia os children se houvesse um Coordinator específico para o Modal (não é o caso)
    }
}
