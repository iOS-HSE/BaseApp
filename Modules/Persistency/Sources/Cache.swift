//
//  Cache.swift
//  IBAMobileBank
//
//  Created by László Teveli on 2020. 04. 06..
//  Copyright © 2020. Shamkhal Guliyev. All rights reserved.
//

import Foundation

public protocol KeyValueStorageProtocol {
    subscript<T: Codable>(key: String) -> T? { get set }
}

public class GenericCache: KeyValueStorageProtocol {
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    var storage: KeyValueDataStorageProtocol
    
    public init(encoder: JSONEncoder,
         decoder: JSONDecoder,
         storage: KeyValueDataStorageProtocol) {
        self.encoder = encoder
        self.decoder = decoder
        self.storage = storage
    }
    
    public subscript<T: Codable>(key: String) -> T? {
        get {
            guard let data = storage[key] as Data? else { return nil }
            return try? decoder.decode(T.self, from: data)
        }
        set(newValue) {
            storage[key] = try? encoder.encode(newValue) as Data
        }
    }
}

public final class InMemoryCache: GenericCache {
    public init(encoder: JSONEncoder = JSONEncoder(),
                decoder: JSONDecoder = JSONDecoder()) {
        super.init(encoder: encoder, decoder: decoder, storage: [:])
    }
}

public final class PersistentCache: GenericCache {
    public init(encoder: JSONEncoder = JSONEncoder(),
         decoder: JSONDecoder = JSONDecoder(),
         storage: KeyValueDataStorageProtocol & AnyObject = UserDefaults.standard) {
        super.init(encoder: encoder, decoder: decoder, storage: storage)
    }
}

public protocol KeyValueDataStorageProtocol {
    subscript(key: String) -> Data? { get set }
}

extension Foundation.UserDefaults: KeyValueDataStorageProtocol {
    public subscript(key: String) -> Data? {
        get {
            data(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }
}

extension Dictionary: KeyValueDataStorageProtocol where Key == String, Value == Data {}
