//
//  DatePickerFieldView.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 23.09.2023.
//

import UIKit

final class DatePickerFieldView: UIView {

    // MARK: - Views

    private let datePickerLabel: UILabel = {
        $0.text = R.string.localizable.section_date_of_birth_placeholder()
        $0.font = AppFonts.poppins14Regular
        $0.textColor = AppColors.softGray
        return $0
    }(UILabel())

    private let datePicker: UIDatePicker = {
        let myDatePicker = UIDatePicker()
        myDatePicker.tintColor = AppColors.coal
        myDatePicker.datePickerMode = .date
        myDatePicker.maximumDate = Date()
        return myDatePicker
    }()

    // MARK: - Public Properties

    public var onDatePickerValueDidChange: ((Date) -> String)?

    public var dateWasChosen: Bool {
        datePickerLabel.text == R.string.localizable.section_date_of_birth_placeholder() ? false : true
    }

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
        setupViews()
        configureConstraints()
        setupBindings()
    }

    private func configure() {
        layer.cornerRadius = Constants.datePickerFieldViewCornerRadius
        layer.borderWidth = Constants.datePickerFieldViewBorderWidth
        layer.borderColor = AppColors.softGray.cgColor
    }

    private func setupViews() {
        addSubviews(
            datePickerLabel,
            datePicker
        )
    }

    private func configureConstraints() {
        datePickerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(AppConstants.spacingMedium)
            make.verticalEdges.equalToSuperview().inset(Constants.datePickerLabelVerticalInsets)
        }

        datePicker.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppConstants.spacingMedium)
            make.centerY.equalTo(datePickerLabel)
        }
    }

    private func setupBindings() {
        datePicker.addTarget(
            self,
            action: #selector(datePickerValueDidChange(_:)),
            for: .valueChanged
        )
    }

    // MARK: - Actions

    @objc
    private func datePickerValueDidChange(_ sender: UIDatePicker) {
        datePickerLabel.text = onDatePickerValueDidChange?(sender.date)
        datePickerLabel.textColor = AppColors.coal
    }

}

// MARK: - Constants

private extension DatePickerFieldView {
    enum Constants {
        static let datePickerLabelVerticalInsets = 13
        static let datePickerFieldViewCornerRadius: CGFloat = 4
        static let datePickerFieldViewBorderWidth: CGFloat = 1
    }
}
