//
//  TokenProvider.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 29.07.2025.
//

import Security
import Foundation

final class TokenProvider {

    static let shared = TokenProvider()
    private init() {}

    private let service = "TMDBService"
    private let account = "tmdb.jwt"

    func save(_ token: String) {
        let data = Data(token.utf8)

        SecItemDelete(baseQuery() as CFDictionary)

        var query = baseQuery()
        query[kSecValueData as String] = data

        SecItemAdd(query as CFDictionary, nil)
    }

    func load() -> String? {
        var query = baseQuery()
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess,
              let data = item as? Data,
              let token = String(data: data, encoding: .utf8) else { return nil }

        return token
    }

    private func baseQuery() -> [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
    }
}

