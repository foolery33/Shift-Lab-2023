//
//  GeneralButton.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 22.09.2023.
//

import UIKit

final class GeneralButton: UIButton {

    // MARK: - Public Properties

    public var onButtonTapped: (() -> Void)?

    // MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    public func setTitle(_ title: String?, for state: UIControl.State, font: UIFont) {
        super.setTitle(title, for: state)
        titleLabel?.font = font
    }

    public func configureGreenFilledButton() {
        layer.backgroundColor = AppColors.darkGreen.cgColor
        layer.cornerRadius = Constants.cornerRadius
        contentEdgeInsets = Constants.contentEdgeInsets
        setTitleColor(AppColors.white, for: .normal)
    }

    // MARK: - Private Methods

    private func setup() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    // MARK: - Action

    @objc
    private func buttonTapped() {
        onButtonTapped?()
    }

}

// MARK: - Constants

private extension GeneralButton {
    enum Constants {
        static let contentEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 0)
        static let cornerRadius = 6.0
    }
}
