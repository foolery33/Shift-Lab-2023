//
//  EventsScreenViewController.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import UIKit

final class EventsScreenViewController: UIViewController {

    // MARK: - Private Properties

    private let viewModel: EventsScreenViewModel

    private let customView: EventsScreenView = .init()

    // MARK: - Inits

    public init(viewModel: EventsScreenViewModel) {
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
        viewModel.viewDidLoad()
    }

    private func setupBindings() {
        viewModel.error.bind { [weak self] error in
            self?.showAlert(error, R.string.localizable.contests_loading_error())
        }

        viewModel.isLoading.bind { [weak self] isLoading in
            self?.setLoaderVisible(isLoading)
        }

        viewModel.contests.bind { [weak self] contests in
            self?.customView.reloadTableView()
        }

        customView.onGreetingButtonTapped = { [weak self] in
            let userName = (self?.viewModel.getUserName()).orEmpty
            self?.showAlert(
                R.string.localizable.greet_user(userName),
                R.string.localizable.hello()
            )
        }

        customView.getContests = { [weak self] in
            return (self?.viewModel.contests.value).orEmptyArray()
        }

        customView.getTimeRange = { [weak self] (time1, time2) in
            return (self?.viewModel.getTimeRange(time1, time2)).orEmpty
        }

        customView.getDateFromString = { [weak self] dateString in
            return (self?.viewModel.getDateFromString(dateString)).orEmpty
        }

        customView.onRefresh = { [weak self] in
            self?.viewModel.updateContests()
        }
    }

}
