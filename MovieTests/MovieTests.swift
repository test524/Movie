//
//  MovieTests.swift
//  MovieTests
//
//  Created by Pavan Kumar Reddy on 15/02/26.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import Movie


final class MovieTests : XCTestCase {

    var vm: MovieViewModel!
    var vmDetails: MovieDetailsViewModel!
    
    override func setUp() {
        print("Class setup")
        vm = MovieViewModel.make()
        vmDetails = MovieDetailsViewModel.make()
    }
    
    override func tearDown() {
        print("Class teardown")
        vm = nil
        vmDetails = nil
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        //if vmDetails != nil {
          //  vmDetails = nil
        //}
    }
    
    func test_fetchPopularMovies() async throws {
        await vm.fetchPopularMovies()
        XCTAssertTrue(vm.popular.count > 0)
    }
    
    func test_fetchNowPlayingMovies() async throws {
        await vm.fetchNowPlayingMovies()
        XCTAssertTrue(vm.nowPlaying.count > 0)
    }
    
    func test_fetchTopRatedMovies() async throws {
        await vm.fetchTopRatedMovies()
        XCTAssertTrue(vm.topRated.count > 0)
    }
    
    func test_fetchupComingMovies() async throws {
        await vm.fetchupComingMovies()
        XCTAssertTrue(vm.upcoming.count > 0)
    }
    
    func testDetailsAPI() async throws {
        await vmDetails.fetchupMovieDetails(id: 1601243)
        XCTAssertNotNil(vmDetails.movieDetails != nil)
    }
    
    func testNowPlayingView() {
        let view = NowPlayingView().environment(AppRouter()).environment(vm)
        assertSnapshot(matching: view, as: .image)
    }
    
    func testPopularMoviesView() {
        let view = PopularMoviesView().environment(AppRouter()).environment(vm)
        assertSnapshot(matching: view, as: .image)
    }
    
    func testTopRatedMoviesPlayingView() {
        let view = TopRatedMoviesView().environment(AppRouter()).environment(vm)
        assertSnapshot(matching: view, as: .image)
    }
    
    func testUpcomingMoviesView() {
        let view = UpcomingMoviesView().environment(AppRouter()).environment(vm)
        assertSnapshot(matching: view, as: .image)
    }
    
}
