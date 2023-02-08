//
//  Scheduler.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//

import Foundation

final class Scheduler {
    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()
    static let mainScheduler = RunLoop.main
}
