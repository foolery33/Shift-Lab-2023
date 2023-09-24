//
//  RegisterInfoStackView.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 22.09.2023.
//

import UIKit

final class RegisterInfoStackView: UIStackView {

    // MARK: - Views

    private lazy var nameTextField: UserInfoSectionStackView = {
        $0.setReturnKeyType(.next)
        return $0
    }(UserInfoSectionStackView(isSecured: false, sectionLabelText: "Имя", placeholderText: "Введите ваше имя"))

    private lazy var surnameTextField: UserInfoSectionStackView = {
        $0.setReturnKeyType(.next)
        return $0
    }(UserInfoSectionStackView(isSecured: false, sectionLabelText: "Фамилия", placeholderText: "Введите вашу фамилию"))

    private lazy var dateOfBirthLabel: UILabel = {
        $0.font = AppFonts.poppins13Medium
        $0.textColor = AppColors.coal
        $0.text = "Дата рождения"
        return $0
    }(UILabel())

    private lazy var dateOfBirthField: DatePickerFieldView = {
        return $0
    }(DatePickerFieldView())

    private lazy var passwordTextField: UserInfoSectionStackView = {
        $0.setReturnKeyType(.next)
        return $0
    }(UserInfoSectionStackView(isSecured: true, sectionLabelText: "Пароль", placeholderText: "Введите ваш пароль"))

    private lazy var confirmPasswordTextField: UserInfoSectionStackView = {
        $0.setReturnKeyType(.done)
        return $0
    }(UserInfoSectionStackView(isSecured: true, sectionLabelText: "Подтвердите пароль", placeholderText: "Введите ваш пароль повторно"))

    // MARK: - Public Properties

    public var onNameTextChanged: ((String) -> Void)?

    public var onSurnameTextChanged: ((String) -> Void)?

    public var onDateOfBirthDateChanged: ((Date) -> String)?

    public var onPasswordTextChanged: ((String) -> Void)?

    public var onConfirmPasswordTextChanged: ((String) -> Void)?

    public var isRegisterButtonEnabled: (() -> Bool)?

    public var onRegisterButtonTapped: (() -> Void)?

    // MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setup() {
        configure()
        setupViews()
        setupBindings()
    }

    private func configure() {
        axis = .vertical
        spacing = 20
    }

    private func setupViews() {
        addArrangedSubviews(
            nameTextField,
            surnameTextField,
            dateOfBirthLabel,
            dateOfBirthField,
            passwordTextField,
            confirmPasswordTextField
        )
        setCustomSpacing(6, after: dateOfBirthLabel)
    }

    private func setupBindings() {
        nameTextField.onTextChanged = { [weak self] text in
            self?.onNameTextChanged?(text)
        }
        nameTextField.onReturnKeyTapped = { [weak self] in
            _ = self?.surnameTextField.becomeFirstResponder()
        }

        surnameTextField.onTextChanged = { [weak self] text in
            self?.onSurnameTextChanged?(text)
        }
        surnameTextField.onReturnKeyTapped = { [weak self] in
            _ = self?.passwordTextField.becomeFirstResponder()
        }

        dateOfBirthField.onDatePickerValueDidChange = { [weak self] date in
            (self?.onDateOfBirthDateChanged?(date)).orEmpty
        }

        passwordTextField.onTextChanged = { [weak self] text in
            self?.onPasswordTextChanged?(text)
        }
        passwordTextField.onReturnKeyTapped = { [weak self] in
            _ = self?.confirmPasswordTextField.becomeFirstResponder()
        }

        confirmPasswordTextField.onTextChanged = { [weak self] text in
            self?.onConfirmPasswordTextChanged?(text)
        }
        confirmPasswordTextField.onReturnKeyTapped = { [weak self] in
            self?.onRegisterButtonTapped?()
        }
    }

}
