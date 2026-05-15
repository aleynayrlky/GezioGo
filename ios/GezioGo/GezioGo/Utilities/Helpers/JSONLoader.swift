import Foundation

enum JSONLoaderError: Error, LocalizedError {
    case fileNotFound(String)
    case decodingFailed(String)

    var errorDescription: String? {
        switch self {
        case .fileNotFound(let filename):
            return "\(filename).json dosyası bulunamadı."
        case .decodingFailed(let message):
            return "JSON decode hatası: \(message)"
        }
    }
}

final class JSONLoader {
    static func load<T: Decodable>(_ filename: String, as type: T.Type) throws -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw JSONLoaderError.fileNotFound(filename)
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw JSONLoaderError.decodingFailed(error.localizedDescription)
        }
    }
}//
//  JSONLoader.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//

