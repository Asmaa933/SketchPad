//
//  HistoryViewModelTest.swift
//  SketchPadTests
//
//  Created by Asmaa Tarek on 14/06/2022.
//

import XCTest
@testable import SketchPad

class HistoryViewModelTest: XCTestCase {
    
    func testLoadHistoryIsEmpty() {
        let viewController = FakeHistoryViewController()
        let viewModel = HistoryViewModel(coordinator:  FakeHistoryCoordinator(),
                                         dataProvider: HistoryDataProvider())
        viewModel.statePresenter = viewController
        viewModel.loadHistory()
        XCTAssertTrue(viewController.isEmpty)
    }
    
    func testLoadHistoryHas1Element() {
        let sketch = Sketch(imageData: UIImage.getImage(from: .logo).jpegData(compressionQuality: 0.5))
        let viewController = FakeHistoryViewController()
        let dataProvider = FakeHistoryDataProvider(sketches: [sketch], shouldReturnError: false)
        let viewModel = HistoryViewModel(coordinator: FakeHistoryCoordinator(),
                                         dataProvider: dataProvider)
        viewModel.statePresenter = viewController
        viewModel.loadHistory()
        XCTAssertEqual(viewModel.getSectionsCount(), 1)
        XCTAssertEqual(viewModel.getTitle(for: 0), Date().toString(format: .dateFormat))
        XCTAssertFalse(viewController.isEmpty, "isEmpty >> \(viewController.isEmpty)")
    }
    
    func testLoadHistoryHas2ElementWithDifferentDates() {
        let imageData = UIImage.getImage(from: .logo).jpegData(compressionQuality: 0.5)
        let sketch1 = Sketch(imageData: imageData)
        let sketch2 = Sketch(id: UUID(), imageData: imageData, imageName: "Test2", date: "14-11-2020", time: "10:00 am", createdAt: "14-11-2020 10:00 am".toDate())
    
        let viewController = FakeHistoryViewController()
        let dataProvider = FakeHistoryDataProvider(sketches: [sketch1,sketch2],
                                                   shouldReturnError: false)
        let viewModel = HistoryViewModel(coordinator: FakeHistoryCoordinator(),
                                         dataProvider: dataProvider)
        viewModel.statePresenter = viewController
        viewModel.loadHistory()
        XCTAssertEqual(viewModel.getSectionsCount(), 2)
        XCTAssertEqual(viewModel.getSketchesCount(in: 0), 1)
        XCTAssertEqual(viewModel.getSketchesCount(in: 0), 1)
        XCTAssertEqual(viewModel.getTitle(for: 0), Date().toString(format: .dateFormat))
        XCTAssertFalse(viewController.isEmpty, "isEmpty >> \(viewController.isEmpty)")
    }
    
    


}
