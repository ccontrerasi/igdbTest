//
//  GameTests.swift
//  igdbTests
//
//  Created by Cristian Contreras on 9/2/23.
//

import XCTest
import Combine
@testable import igdb

final class GameTests: XCTestCase {
    
    private var gameRempositoryMockup: IGameRepository!
    private var cancellables: [AnyCancellable]!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameRempositoryMockup = GameRepositoryMockup()
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSuccessParserFileJson() {
        let path = Bundle(for: GameRepositoryMockup.self).path(forResource: "games.json", ofType: nil)
        XCTAssertNotNil(path)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        XCTAssertNotNil(data)
        let games = try? JSONDecoder().decode([GameDTO].self, from: data!)
        XCTAssertNotNil(games)
        XCTAssertEqual(games?.first?.id, 35004)
    }
    
    func testReadListOfGameAndCheckCoversExists(){
        // Given
        var result: LoadableState<Home>!
        let expectation = self.expectation(description: "games")
        let uc = HomeUseCase(gameRepository: gameRempositoryMockup)
        uc.execute(offset: 50).sink { state in
            result = state
            expectation.fulfill()
        }.store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .result(let home) = result! else {
            XCTFail()
            return
        }
        
        let gameWithCover = home.games.first { !($0.covers?.isEmpty ?? false)}
        XCTAssertNotNil(gameWithCover)
        
    }
}
