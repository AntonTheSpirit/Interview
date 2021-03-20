//
//  InterviewModel.swift
//  Interview Houding & Gedrag
//
//  Created by Anton Verver on 1610--2020.


import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let interviewTemplates: InterviewTemplates
}

// MARK: Welcome convenience initializers and mutators

extension Welcome {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Welcome.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        interviewTemplates: InterviewTemplates? = nil
    ) -> Welcome {
        return Welcome(
            interviewTemplates: interviewTemplates ?? self.interviewTemplates
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - InterviewTemplates
struct InterviewTemplates: Codable {
    let dnaInterview: DNAInterview

    enum CodingKeys: String, CodingKey {
        case dnaInterview = "DNA_Interview"
    }
}

// MARK: InterviewTemplates convenience initializers and mutators

extension InterviewTemplates {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(InterviewTemplates.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        dnaInterview: DNAInterview? = nil
    ) -> InterviewTemplates {
        return InterviewTemplates(
            dnaInterview: dnaInterview ?? self.dnaInterview
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DNAInterview
struct DNAInterview: Codable {
    let vragen: [Vragen]
}

// MARK: DNAInterview convenience initializers and mutators

extension DNAInterview {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DNAInterview.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        vragen: [Vragen]? = nil
    ) -> DNAInterview {
        return DNAInterview(
            vragen: vragen ?? self.vragen
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Vragen
struct Vragen: Codable {
    var vraagNummer: Int
    var eigenschap, vraagID, vraag: String
    var antwoorden: [Antwoorden]
}

// MARK: Vragen convenience initializers and mutators

extension Vragen {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Vragen.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        vraagNummer: Int? = nil,
        eigenschap: String? = nil,
        vraagID: String? = nil,
        vraag: String? = nil,
        antwoorden: [Antwoorden]? = nil
    ) -> Vragen {
        return Vragen(
            vraagNummer: vraagNummer ?? self.vraagNummer,
            eigenschap: eigenschap ?? self.eigenschap,
            vraagID: vraagID ?? self.vraagID,
            vraag: vraag ?? self.vraag,
            antwoorden: antwoorden ?? self.antwoorden
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Antwoorden
struct Antwoorden: Codable {
    let antwoordNummer: Int
    let antwoordID, antwoord: String
    let score: Double
}

// MARK: Antwoorden convenience initializers and mutators

extension Antwoorden {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Antwoorden.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        antwoordNummer: Int? = nil,
        antwoordID: String? = nil,
        antwoord: String? = nil,
        score: Double? = nil
    ) -> Antwoorden {
        return Antwoorden(
            antwoordNummer: antwoordNummer ?? self.antwoordNummer,
            antwoordID: antwoordID ?? self.antwoordID,
            antwoord: antwoord ?? self.antwoord,
            score: score ?? self.score
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

