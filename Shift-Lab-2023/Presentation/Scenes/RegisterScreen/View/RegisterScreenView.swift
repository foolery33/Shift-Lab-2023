//
//  RegisterScreenView.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 21.09.2023.
//

import UIKit
import SnapKit

final class RegisterScreenView: UIView {

    // MARK: - Views

    private let scrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        $0.delaysContentTouches = false
        return $0
    }(UIScrollView())

    private let contentView: UIView = {
        return $0
    }(UIView())

    private let registerHeaderStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        return $0
    }(UIStackView())

    private let createAccountLabel: UILabel = {
        $0.text = R.string.localizable.create_account()
        $0.font = AppFonts.poppins21Semibold
        $0.textColor = AppColors.black
        return $0
    }(UILabel())

    private let registerPhraseLabel: UILabel = {
        $0.text = R.string.localizable.participate_in_contests()
        $0.textColor = AppColors.gray
        $0.font = AppFonts.poppins14Regular
        return $0
    }(UILabel())

    private let registerInfoStackView: RegisterInfoStackView = {
        return $0
    }(RegisterInfoStackView())

    private lazy var registerButton: GeneralButton = {
        $0.configureGreenFilledButton()
        $0.setTitle(R.string.localizable.register_button(), for: .normal, font: AppFonts.poppins14Regular)
        return $0
    }(GeneralButton(type: .system))

    // MARK: - Public Properties

    public var onNameTextChanged: ((String) -> Void)?

    public var onSurnameTextChanged: ((String) -> Void)?

    public var onDateOfBirthTextChanged: ((Date) -> String)?

    public var onPasswordTextChanged: ((String) -> Void)?

    public var onConfirmPasswordTextChanged: ((String) -> Void)?

    public var onRegisterButtonTapped: (() -> Void)?

    // MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setup() {
        configure()
        setupHideKeyboard()
        setupViews()
        configureConstraints()
        setupBindings()
        addObservers()
    }

    private func configure() {
        backgroundColor = AppColors.white
    }

    private func setupViews() {
        addSubview(scrollView)

        scrollView.addSubview(contentView)

        contentView.addSubviews(
            registerHeaderStackView,
            registerInfoStackView,
            registerButton
        )

        registerHeaderStackView.addArrangedSubviews(
            createAccountLabel,
            registerPhraseLabel
        )
    }

    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
        }

        registerHeaderStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(AppConstants.spacingLarge)
            make.top.equalToSuperview().offset(Constants.registerHeaderStackViewTopOffset)
        }

        registerInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(registerHeaderStackView.snp.bottom).offset(Constants.registerInfoStackViewTopOffset)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.spacingLarge)
            make.bottom.lessThanOrEqualTo(registerButton.snp.top).offset(-AppConstants.spacingLarge)
        }

        registerButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(registerInfoStackView.snp.bottom).offset(AppConstants.spacingLarge)
            make.bottom.equalToSuperview().offset(-AppConstants.spacingLarge)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.spacingLarge)
        }
    }

    private func setupBindings() {
        registerInfoStackView.onNameTextChanged = { [weak self] text in
            self?.onNameTextChanged?(text)
        }

        registerInfoStackView.onSurnameTextChanged = { [weak self] text in
            self?.onSurnameTextChanged?(text)
        }

        registerInfoStackView.onDateOfBirthDateChanged = { [weak self] date in
            (self?.onDateOfBirthTextChanged?(date)).orEmpty
        }

        registerInfoStackView.onPasswordTextChanged = { [weak self] text in
            self?.onPasswordTextChanged?(text)
        }

        registerInfoStackView.onConfirmPasswordTextChanged = { [weak self] text in
            self?.onConfirmPasswordTextChanged?(text)
        }

        registerButton.onButtonTapped = { [weak self] in
            self?.onRegisterButtonTapped?()
        }
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIWindow.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIWindow.keyboardWillHideNotification,
            object: nil
        )
    }

    // MARK: - Actions

    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue
        )?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: keyboardSize.height + AppConstants.spacingLarge,
                right: 0
            )
        }
    }

    @objc
    private func keyboardWillHide(_ notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }

    // MARK: - Deinit

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - Constants

private extension RegisterScreenView {
    enum Constants {
        static let registerHeaderStackViewTopOffset = 30
        static let registerInfoStackViewTopOffset = 24
        
    }
}
