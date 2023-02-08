//
//  EnviromentContainer.swift
//
//  Created by Cristian Contreras
//

import Foundation

public class EnviromentContainer: ObservableObject {
    @Published var dataMap: [String: Any] = [:]

    public init() { }

    public func register(id: String, data: Any) {
        dataMap[id] = data
    }

    public func register(childEnvironment: EnviromentContainer) {
        childEnvironment.dataMap.forEach { k, v in dataMap[k] = v }
    }

    public func get(id: String) -> Any? {
        dataMap[id]
    }
}
