//
//  UserInfoSectionStackView.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 22.09.2023.
//

import UIKit

final class UserInfoSectionStackView: UIStackView {

    // MARK: - Views

    private lazy var sectionLabel: UILabel = {
        $0.font = AppFonts.poppins13Medium
        $0.textColor = AppColors.coal
        $0.text = sectionLabelText
        return $0
    }(UILabel())

    private lazy var textField: GeneralTextField = {
        return $0
    }(GeneralTextField(isSecured: isSecured, placeholderText: placeholderText))

    // MARK: - Public Properties

    public var isSecured: Bool

    public var sectionLabelText: String

    public var placeholderText: String

    public var onTextChanged: ((String) -> Void)?

    public var onReturnKeyTapped: (() -> Void)?

    // MARK: - Inits

    public init(
        isSecured: Bool,
        sectionLabelText: String,
        placeholderText: String
    ) {
        self.isSecured = isSecured
        self.sectionLabelText = sectionLabelText
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    public override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
    }

    public func setReturnKeyType(_ type: UIReturnKeyType) {
        textField.setReturnKeyType(type)
    }

    // MARK: - Private Methods

    private func setup() {
        configure()
        setupViews()
        setupBindings()
    }

    private func configure() {
        axis = .vertical
        spacing = Constants.userInfoSectionStackViewSpacing
    }

    private func setupViews() {
        addArrangedSubviews(
            sectionLabel,
            textField
        )
    }

    private func setupBindings() {
        textField.onTextFieldValueChanged = { [weak self] text in
            self?.onTextChanged?(text)
        }

        textField.onReturnKeyTapped = { [weak self] in
            self?.onReturnKeyTapped?()
        }
    }

}

// MARK: - Constants

private extension UserInfoSectionStackView {
    enum Constants {
        static let userInfoSectionStackViewSpacing: CGFloat = 6
    }
}
