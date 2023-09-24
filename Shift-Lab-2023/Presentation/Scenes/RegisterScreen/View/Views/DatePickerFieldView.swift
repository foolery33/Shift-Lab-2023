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
        $0.text = "Выберите дату рождения"
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
        datePickerLabel.text == "Выберите дату рождения" ? false : true
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
        layer.cornerRadius = 4
        layer.borderWidth = 1
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
            make.leading.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(13)
        }

        datePicker.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
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
