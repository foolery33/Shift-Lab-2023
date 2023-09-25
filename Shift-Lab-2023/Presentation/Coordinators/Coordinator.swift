//
//  Coordinator.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 21.09.2023.
//

import UIKit

public protocol Coordinator: AnyObject {
    // MARK: - Properties
    var rootViewController: UIViewController { get }

    var children: [Coordinator] { get }

    // MARK: - Methods
    func start()
}
