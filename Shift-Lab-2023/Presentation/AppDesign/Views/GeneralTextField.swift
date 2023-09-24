//
//  GeneralTextField.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 22.09.2023.
//

import UIKit

class GeneralTextField: UITextField {

    // MARK: - Views

    private lazy var passwordEyeButton: UIButton = {
        $0.setImage(
            UIImage(systemName: "eye")?.resizeImage(
                newWidth: Constants.eyeSize,
                newHeight: Constants.eyeSize
            ) ?? .init(),
            for: .normal
        )
        $0.tintColor = AppColors.gray
        $0.addTarget(
            self,
            action: #selector(onPasswordEyeButtonTapped),
            for: .touchUpInside
        )
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIButton(type: .system))

    private lazy var textFieldLabel: UILabel = {
        $0.font = AppFonts.poppins13Medium
        $0.textColor = AppColors.coal
        return $0
    }(UILabel())

    // MARK: - Public Properties

    public var onReturnKeyTapped: (() -> Void)?

    public var onTextFieldValueChanged: ((String) -> Void)?

    // MARK: - Private Properties

    private let isSecured: Bool

    private let placeholderText: String

    // MARK: - Inits

    required init(isSecured: Bool, placeholderText: String) {
        self.isSecured = isSecured
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        delegate = self
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    public func setReturnKeyType(_ type: UIReturnKeyType) {
        returnKeyType = type
    }

    // MARK: - Private Methods

    private func setup() {
        configure()
    }

    private func configure() {
        autocapitalizationType = .none
        textColor = AppColors.coal
        font = AppFonts.poppins14Regular
        backgroundColor = AppColors.transparent
        isSecureTextEntry = isSecured
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = AppColors.softGray.cgColor
        sizeToFit()
        attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [
                NSAttributedString.Key.font: AppFonts.poppins14Regular,
                NSAttributedString.Key.foregroundColor: AppColors.softGray
            ]
        )
        if isSecured {
            rightView = passwordEyeButton
            rightViewMode = .always
        }

        addTarget(
            self,
            action: #selector(textFieldValueChanged),
            for: .editingChanged
        )
    }

    private func setupViews() {
        addSubview(textFieldLabel)
    }

    private func configureConstraints() {

    }

    // MARK: - Actions

    @objc
    private func textFieldValueChanged() {
        onTextFieldValueChanged?(text ?? "")
    }

    @objc
    private func onPasswordEyeButtonTapped(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            sender.setImage(
                UIImage(systemName: "eye")?.resizeImage(
                    newWidth: Constants.eyeSize,
                    newHeight: Constants.eyeSize
                ) ?? .init(),
                for: .normal
            )
        } else {
            sender.setImage(
                UIImage(systemName: "eye.slash")?.resizeImage(
                    newWidth: Constants.eyeSize,
                    newHeight: Constants.eyeSize
                ) ?? .init(),
                for: .normal
            )
        }
    }

    // MARK: - Overridden Methods

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(
            by: self.isSecured ?
            Constants.securedTextFieldEdgeInsets :
                Constants.insecuredTextFieldEdgeInsets
        )
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(
            by: self.isSecured ?
            Constants.securedTextFieldEdgeInsets :
                Constants.insecuredTextFieldEdgeInsets
        )
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(
            by: self.isSecured ?
            Constants.securedTextFieldEdgeInsets :
                Constants.insecuredTextFieldEdgeInsets
        )
    }
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset: CGFloat = Constants.eyeOffset
        let width: CGFloat  = Constants.eyeSize
        let height = width
        let x = CGFloat(Int(bounds.width) - Int(width) - Int(offset))
        let y = self.bounds.height / 2 - Constants.eyeSize / 2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }

}

// MARK: - Constants
private extension GeneralTextField {
    enum Constants {
        static let securedTextFieldEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 16,
            bottom: 13,
            right: 48
        )

        static let insecuredTextFieldEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 16,
            bottom: 13,
            right: 16
        )

        static let eyeSize: CGFloat = 22

        static let eyeOffset: CGFloat = 16
    }
}

// MARK: - UITextFieldDelegate

extension GeneralTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onReturnKeyTapped?()
        return true
    }
}
