//
//  itunesapiTests.swift
//  itunesapiTests
//
//  Created by dpsmac1 on 08-05-18.
//  Copyright © 2018 Alejandro Iván. All rights reserved.
//

import XCTest
@testable import itunesapi

class itunesapiTests: XCTestCase {
    var searchInteractor: SearchInteractor!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        searchInteractor = SearchInteractor()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLocalSearch() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let medias = [
            Media(wrapperType: "song", artistName: "artistName", collectionId: 1, collectionName: "collectionName", kind: "kind", trackId: 1, trackName: "trackName", trackNumber: 1, artwork: "http://www.google.com", previewUrl: "http://www.google.com")
        ]
        
        // Guardar como resultado local
        do {
            let jsonData = try JSONEncoder().encode(medias)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                searchInteractor.saveLocalResults(for: "google", json: jsonString)
            }
        } catch {
            print("No se pudo guardar el json.")
        }
        
        // Obtener resultados locales y evaluar desde ellos
        let results = searchInteractor.fetchLocalResults(for: "google")
        XCTAssert(results.count == 1, "El número de resultados para \"google\" es incorrecto.")
        
        let first = results.first
        XCTAssertNotNil(first, "No se pudo obtener el resultado de \"google\".")
        
        if let m = first {
            XCTAssert(m.wrapperType == "song")
            XCTAssert(m.artistName == "artistName")
            XCTAssert(m.collectionId! == 1)
            XCTAssert(m.collectionName! == "collectionName")
            XCTAssert(m.kind! == "kind")
            XCTAssert(m.trackId! == 1)
            XCTAssert(m.trackName! == "trackName")
            XCTAssert(m.trackNumber! == 1)
            XCTAssert(m.artwork! == "http://www.google.com")
            XCTAssert(m.previewUrl! == "http://www.google.com")
            XCTAssertNotNil(m.urlForArtwork)
            XCTAssertNotNil(m.urlForPreview)
            XCTAssert(m.urlForArtwork!.absoluteString == "http://www.google.com")
            XCTAssert(m.urlForPreview!.absoluteString == "http://www.google.com")
        }
    }
    
}
