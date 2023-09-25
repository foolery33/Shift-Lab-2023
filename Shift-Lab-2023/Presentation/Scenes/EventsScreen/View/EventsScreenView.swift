//
//  EventsScreenView.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import UIKit

final class EventsScreenView: UIView {

    // MARK: - Views

    private let headerStackView: UIStackView = {
        $0.spacing = AppConstants.spacingMedium
        $0.layer.backgroundColor = AppColors.softWhite.cgColor
        $0.layoutMargins = Constants.headerStackViewLayoutMargins
        $0.isLayoutMarginsRelativeArrangement = true
        $0.alignment = .center
        return $0
    }(UIStackView())

    private let recommendedContestsLabel: UILabel = {
        $0.text = R.string.localizable.recommended_contests()
        $0.numberOfLines = .zero
        $0.font = AppFonts.poppins25Semibold
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return $0
    }(UILabel())

    private lazy var greetingButton: GeneralButton = {
        $0.setTitle(R.string.localizable.greeting(), for: .normal, font: AppFonts.poppins14Regular)
        $0.configureLightGreenFilledButton()
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        $0.addTarget(
            self,
            action: #selector(greetingButtonTapped),
            for: .touchUpInside
        )
        return $0
    }(GeneralButton(type: .system))

    private lazy var contestsTableView: UITableView = {
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.register(
            ContestsTableViewCell.self,
            forCellReuseIdentifier: ContestsTableViewCell.reuseIdentifier
        )
        let refresher = UIRefreshControl()
        refresher.addTarget(
            self,
            action: #selector(updateContests),
            for: .valueChanged
        )
        $0.refreshControl = refresher
        return $0
    }(UITableView())

    // MARK: - Public Properties

    public var onGreetingButtonTapped: (() -> Void)?

    public var getContests: (() -> [ContestDomain])?

    public var getDateFromString: ((String) -> String)?

    public var getTimeRange: ((String, String) -> String)?

    public var onRefresh: (() -> Void)?

    // MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    public func reloadTableView() {
        contestsTableView.reloadData()
    }

    // MARK: - Private Methods

    private func setup() {
        configure()
        setupViews()
        configureConstraints()
    }

    private func configure() {
        backgroundColor = AppColors.white
    }

    private func setupViews() {
        addSubviews(
            headerStackView,
            contestsTableView
        )

        headerStackView.addArrangedSubviews(
            recommendedContestsLabel,
            greetingButton
        )
    }

    private func configureConstraints() {
        headerStackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }

        contestsTableView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }

    // MARK: - Actions

    @objc
    private func greetingButtonTapped() {
        onGreetingButtonTapped?()
    }

    @objc
    private func updateContests() {
        onRefresh?()
        contestsTableView.refreshControl?.endRefreshing()
    }

}

// MARK: - UITableViewDelegate

extension EventsScreenView: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource

extension EventsScreenView: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return (getContests?().count).orZero
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: ContestsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? ContestsTableViewCell {
            if let contests = getContests?() {
                cell.configureCell(
                    startDate: (getDateFromString?(contests[indexPath.row].startTime)).orEmpty,
                    endDate: (getDateFromString?(contests[indexPath.row].endTime)).orEmpty,
                    time: (
                        getTimeRange?(
                            contests[indexPath.row].startTime,
                            contests[indexPath.row].endTime
                        )
                    ).orEmpty,
                    contestName: contests[indexPath.row].name
                )
                cell.onContestTapped = {
                    if let url = URL(string: contests[indexPath.row].url) {
                        UIApplication.shared.open(url)
                    }
                }
                return cell
            }
        }
        return .init()
    }
}

// MARK: - Constants

private extension EventsScreenView {
    enum Constants {
        static let headerStackViewLayoutMargins = UIEdgeInsets(
            top: 30,
            left: 20,
            bottom: 20,
            right: 20
        )
    }
}
