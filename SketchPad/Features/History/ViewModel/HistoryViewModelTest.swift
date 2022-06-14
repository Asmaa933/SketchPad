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
        let sketch1 = Sketch(imageData: imageData,imageName: "Test1")
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
        XCTAssertEqual(viewModel.getSketchesCount(in: 1), 1)
        XCTAssertEqual(viewModel.getTitle(for: 0), Date().toString(format: .dateFormat))
        XCTAssertFalse(viewController.isEmpty, "isEmpty >> \(viewController.isEmpty)")
    }
    
    func testGetSketch()  {
        let imageData = UIImage.getImage(from: .logo).jpegData(compressionQuality: 0.5)
        let sketch1 = Sketch(imageData: imageData,imageName: "Test1")
        let sketch2 = Sketch(imageData: imageData, imageName: "Test2")
        let sketch3 = Sketch(id: UUID(), imageData: imageData, imageName: "Test3", date: "14-11-2020", time: "10:00 am", createdAt: "14-11-2020 10:00 am".toDate())
        let viewController = FakeHistoryViewController()
        let dataProvider = FakeHistoryDataProvider(sketches: [sketch1, sketch2,sketch3],
                                                   shouldReturnError: false)
        let viewModel = HistoryViewModel(coordinator: FakeHistoryCoordinator(),
                                         dataProvider: dataProvider)
        viewModel.statePresenter = viewController
        viewModel.loadHistory()
        XCTAssertEqual(viewModel.getSectionsCount(), 2)
        XCTAssertEqual(viewModel.getSketchesCount(in: 0), 2)
        XCTAssertEqual(viewModel.getSketchesCount(in: 1), 1)
        XCTAssertEqual(viewModel.getSketch(for: IndexPath(row: 1, section: 0))?.imageName, "Test1")
        XCTAssertFalse(viewController.isEmpty, "isEmpty >> \(viewController.isEmpty)")
    }
    
    func testSketchDidSelect() {
        let imageData = UIImage.getImage(from: .logo).jpegData(compressionQuality: 0.5)
        let sketch1 = Sketch(imageData: imageData,imageName: "Test1")
        let viewController = FakeHistoryViewController()
        let dataProvider = FakeHistoryDataProvider(sketches: [sketch1],
                                                   shouldReturnError: false)
        let coordinator = FakeHistoryCoordinator()
        let viewModel = HistoryViewModel(coordinator: coordinator,
                                         dataProvider: dataProvider)
        viewModel.statePresenter = viewController
        viewModel.loadHistory()
        viewModel.sketchDidSelected(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(coordinator.previewedSketchUUID, sketch1.id)
    }
    
    func testDeleteSketch() {
        let imageData = UIImage.getImage(from: .logo).jpegData(compressionQuality: 0.5)
        let sketch1 = Sketch(imageData: imageData,imageName: "Test1")
        let sketch2 = Sketch(imageData: imageData, imageName: "Test2")
        let viewController = FakeHistoryViewController()
        let dataProvider = FakeHistoryDataProvider(sketches: [sketch1, sketch2],
                                                   shouldReturnError: false)
        let coordinator = FakeHistoryCoordinator()
        let viewModel = HistoryViewModel(coordinator: coordinator,
                                         dataProvider: dataProvider)
        viewModel.statePresenter = viewController
        viewModel.loadHistory()
        viewModel.deleteSketch(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(coordinator.errorShowed)
    }

}
