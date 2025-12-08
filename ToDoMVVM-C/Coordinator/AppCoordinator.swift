//
//  AppCoordinator.swift
//  ToDoMVVM-C
//
//  Created by Enzo Henrique Botelho Romão on 08/12/25.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var children: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToHome()
    }
    
    private func goToHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        children.append(homeCoordinator)
        homeCoordinator.start()
    }
}
