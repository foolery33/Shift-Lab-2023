//
//  LoaderView.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 25.09.2023.
//

import UIKit

class LoaderView: UIView {

    // MARK: - Views

    private let view = UIView()

    private let activityIndicator = UIActivityIndicatorView()

    // MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Private Methods

    private func setup() {
        view.backgroundColor = AppColors.softGreen
        view.layer.cornerRadius = 8

        activityIndicator.startAnimating()
        activityIndicator.color = AppColors.darkGreen

        view.addSubview(activityIndicator)
        addSubview(view)

        view.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.center.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
