//
//  GameTests.swift
//  igdbTests
//
//  Created by Cristian Contreras on 9/2/23.
//

import XCTest

final class GameTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSuccessParser() {
            let json = """
            [
                {
                    "id": 35004,
                    "category": 0,
                    "created_at": 1495818975,
                    "external_games": [
                        8077,
                        1957344
                    ],
                    "first_release_date": 1437696000,
                    "game_modes": [
                        2,
                        5
                    ],
                    "genres": [
                        15,
                        32
                    ],
                    "name": "Demon Horde Master",
                    "platforms": [
                        6
                    ],
                    "release_dates": [
                        80453
                    ],
                    "screenshots": [
                        82910,
                        82911,
                        82912,
                        82913,
                        82914
                    ],
                    "similar_games": [
                        33603,
                        36962,
                        51577,
                        65827,
                        79134,
                        107992,
                        111043,
                        113402,
                        115539,
                        116674
                    ],
                    "slug": "demon-horde-master",
                    "summary": "In Demon Horde Master you fight your opponent in a 1-on-1 chess like strategy card game with your own army of demons through which you cast your powerful magic and defeat your opponent to become the new leader of hell! For this you have 45 different spells, and 20 demons available.",
                    "tags": [
                        268435471,
                        268435488
                    ],
                    "updated_at": 1670980302,
                    "url": "https://www.igdb.com/games/demon-horde-master",
                    "websites": [
                        36419,
                        36420,
                        414562
                    ],
                    "checksum": "89eea997-2e78-d97e-0a09-6c4ea7b0014d"
                }
            ]
            """.data(using: .utf8)!
            
            let games = try? JSONDecoder().decode([GameDTO].self, from: json)
            
            XCTAssertNotNil(games)
            XCTAssertEqual(games?.first?.id, 35004)
            
        }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
