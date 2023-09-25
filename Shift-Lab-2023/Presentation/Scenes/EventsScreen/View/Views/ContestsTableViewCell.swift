//
//  ContestsTableViewCell.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import UIKit

class ContestsTableViewCell: UITableViewCell {

    // MARK: - Views

    private let dateStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = Constants.dateStackViewSpacing
        return $0
    }(UIStackView())

    private let startDateLabel: UILabel = {
        $0.textColor = AppColors.coal
        $0.font =  AppFonts.poppins17Medium
        return $0
    }(UILabel())

    private let endDateLabel: UILabel = {
        $0.textColor = AppColors.softGray
        $0.font =  AppFonts.poppins13Medium
        return $0
    }(UILabel())

    private let timeSpacerView: UIView = {
        $0.setContentHuggingPriority(.defaultLow, for: .vertical)
        return $0
    }(UIView())

    private lazy var contestCardInfoView: UIView = {
        $0.backgroundColor = AppColors.softBlue
        $0.layer.cornerRadius = Constants.contestCardInfoViewCornerRadius
        $0.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(contestTapped)
            )
        )
        return $0
    }(UIView())

    private let contestTimeLabel: UILabel = {
        $0.font = AppFonts.poppins13Medium
        $0.textColor = AppColors.darkGreen
        return $0
    }(UILabel())

    private let contestNameLabel: UILabel = {
        $0.font = AppFonts.poppins21Medium
        $0.textColor = AppColors.coal
        $0.numberOfLines = .zero
        return $0
    }(UILabel())

    // MARK: - Public Properties

    public var onContestTapped: (() -> Void)?

    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    public func configureCell(
        startDate: String,
        endDate: String,
        time: String,
        contestName: String
    ) {
        startDateLabel.text = startDate
        endDateLabel.text = endDate
        contestTimeLabel.text = time
        contestNameLabel.text = contestName
    }

    // MARK: - Private Methods

    private func setup() {
        configure()
        setupViews()
        configureConstraints()
    }

    private func configure() {
        selectionStyle = .none
    }

    private func setupViews() {
        contentView.addSubviews(
            dateStackView,
            contestCardInfoView
        )

        dateStackView.addArrangedSubviews(
            startDateLabel,
            endDateLabel,
            timeSpacerView
        )

        contestCardInfoView.addSubviews(
            contestTimeLabel,
            contestNameLabel
        )
    }

    private func configureConstraints() {
        dateStackView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(AppConstants.spacingLarge)
            make.bottom.equalToSuperview()
            make.width.equalTo(Constants.dateStackViewWidth)
        }

        contestCardInfoView.snp.makeConstraints { make in
            make.leading.equalTo(dateStackView.snp.trailing).offset(
                Constants.contestCardInfoViewLeadingOffset
            )
            make.trailing.equalToSuperview().inset(AppConstants.spacingLarge)
            make.top.equalTo(dateStackView.snp.top)
            make.bottom.equalToSuperview()
        }

        contestTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(AppConstants.spacingTiny)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.spacingLarge)
        }

        contestNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contestTimeLabel.snp.bottom).offset(AppConstants.spacingTiny)
            make.bottom.equalToSuperview().inset(AppConstants.spacingTiny)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.spacingLarge)
        }
    }

    // MARK: - Actions

    @objc
    private func contestTapped() {
        onContestTapped?()
    }

}

// MARK: - Constants

private extension ContestsTableViewCell {
    enum Constants {
        static let dateStackViewSpacing: CGFloat = 6
        static let dateStackViewWidth = 100

        static let contestCardInfoViewCornerRadius: CGFloat = 10
        static let contestCardInfoViewLeadingOffset = 10
    }
}
