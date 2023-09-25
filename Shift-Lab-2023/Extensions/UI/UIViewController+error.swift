//
//  UIViewController+error.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 21.09.2023.
//

import UIKit

extension UIViewController {

    public func showAlert(_ message: String, _ title: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(
            title: R.string.localizable.ok(),
            style: .default
        )

        alertController.addAction(okAction)

        present(alertController, animated: true)
    }
}
