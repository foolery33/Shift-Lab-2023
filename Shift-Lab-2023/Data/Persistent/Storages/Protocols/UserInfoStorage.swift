//
//  UserInfoStorage.swift
//  Shift-Lab-2023
//
//  Created by Nikita Usov on 24.09.2023.
//

protocol UserInfoStorage {

    // MARK: - Properties

    var name: String? { get }

    // MARK: - Methods

    func saveName(_ name: String)

    func removeName()

    func clearStorage()

}
