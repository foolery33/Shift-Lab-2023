//
//  RegisterScreenViewController.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 21.09.2023.
//

import UIKit

final class RegisterScreenViewController: UIViewController {

    // MARK: - Private Properties

    private let viewModel: RegisterScreenViewModel

    private let customView: RegisterScreenView = .init()

    // MARK: - Inits

    public init(viewModel: RegisterScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Private Methods

    private func setup() {
        setupBindings()
    }

    private func setupBindings() {
        viewModel.error.bind { [weak self] error in
            self?.showError(error, "Ошибка регистрации")
        }

        customView.onNameTextChanged = { [weak self] text in
            self?.viewModel.updateName(text)
        }

        customView.onSurnameTextChanged = { [weak self] text in
            self?.viewModel.updateSurname(text)
        }

        customView.onDateOfBirthTextChanged = { [weak self] date in
            (self?.viewModel.updateDateOfBirth(date)).orEmpty
        }

        customView.onPasswordTextChanged = { [weak self] text in
            self?.viewModel.updatePassword(text)
        }

        customView.onConfirmPasswordTextChanged = { [weak self] text in
            self?.viewModel.updateConfirmPassword(text)
        }

        customView.onRegisterButtonTapped = { [weak self] in
            self?.viewModel.registerUser()
        }
    }

}
