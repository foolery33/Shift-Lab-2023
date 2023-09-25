//
//  UIViewController+loader.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 25.09.2023.
//

import Foundation
import UIKit

extension UIViewController {
    private var loaderTag: Int { 198765 }

    func setLoaderVisible(_ value: Bool) {
        if value {
            showLoader()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.hideLoader()
            }
        }
    }

    private func showLoader() {
        guard
            let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
              window.subviews.first(where: { $0.tag == loaderTag }) == nil
        else {
            return
        }

        let loaderView = LoaderView()
        loaderView.tag = loaderTag

        window.addSubview(loaderView)
        loaderView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.isUserInteractionEnabled = false
    }

    private func hideLoader() {
        view.isUserInteractionEnabled = true
        guard
            let loaderView = UIApplication
                .shared
                .windows
                .filter({$0.isKeyWindow})
                .first?
                .subviews
                .first(where: { $0.tag == loaderTag })
        else {
            return
        }

        loaderView.removeFromSuperview()
    }
}

