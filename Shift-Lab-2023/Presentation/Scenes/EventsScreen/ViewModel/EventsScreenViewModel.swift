//
//  EventsScreenViewModel.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

import Foundation

protocol EventsScreenViewModel {

    // MARK: - Input

    func viewDidLoad()
    func getTimeRange(_ time1: String, _ time2: String) -> String?
    func getDateFromString(_ dateString: String) -> String?
    func getUserName() -> String
    func updateContests()

    // MARK: - Output

    var contests: Dynamic<[ContestDomain]> { get }
    var isLoading: Dynamic<Bool> { get }
    var error: Dynamic<String> { get }

}

final class EventsScreenViewModelImpl: EventsScreenViewModel {

    // MARK: - Private Properties

    private let dependencies: Dependencies

    // MARK: - Init

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Input

    public func viewDidLoad() {
        getContests()
    }

    public func getTimeRange(_ time1: String, _ time2: String) -> String? {
        dependencies.getTimeRangeUseCase.invoke(timeString1: time1, timeString2: time2)
    }

    public func getDateFromString(_ dateString: String) -> String? {
        dependencies.getDateFromStringUseCase.invoke(dateString: dateString)
    }

    public func getUserName() -> String {
        dependencies.getUserNameUseCase.invoke()
    }

    public func updateContests() {
        getContests()
    }

    // MARK: - Output

    public var contests: Dynamic<[ContestDomain]> = .init(.init())

    public var isLoading: Dynamic<Bool> = .init(.init())
    
    public var error: Dynamic<String> = .init(.init())

    // MARK: - Private Methods

    private func getContests() {
        isLoading.value = true
        dependencies.getContestsUseCase.invoke { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let domain):
                self?.contests.value = domain

            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }

}

// MARK: - NestedTypes

extension EventsScreenViewModelImpl {
    struct Dependencies {
        let getContestsUseCase: GetContestsUseCase
        let getDateFromStringUseCase: GetDateFromStringUseCase
        let getTimeRangeUseCase: GetTimeRangeUseCase
        let getUserNameUseCase: GetUserNameUseCase
    }
}
