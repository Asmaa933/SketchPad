//
//  DrawingViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation
import UIKit

enum Mode {
    case drawing
    case delete
}

protocol DrawingViewModelProtocol {
    var statePresenter: StatePresentable? { get set }
    func getImage()
    func topBarButtonTapped(_ button: DrawingTopBarButton)
    func didTouchImage(at point: CGPoint, eventType: TouchEvent)
    func bottomBarActionFired(_ action: BottomBarAction)
    func doneButtonTapped(imageData: Data?)
}

class DrawingViewModel {
    
    private var coordinator: DrawingCoordinatorProtocol
    private lazy var linesInfo = [LineInfo]()
    private lazy var deletedLines = [LineInfo]()
    private var currentColor: UIColor = .black
    private var currentThickness: CGFloat = 20
    private var currentMode: Mode = .drawing
    
    var statePresenter: StatePresentable?
    
    init(coordinator: DrawingCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

fileprivate extension DrawingViewModel {
    
    func getImageFromCoordinator() {
        coordinator.imageDidPicked = {[weak self] imageData in
            guard let self = self else { return }
            self.statePresenter?.render(state: .imagePicked(imageData: imageData),
                                        mapping: DrawingState.self)
        }
        coordinator.showImagePicker()
    }
}

extension DrawingViewModel: DrawingViewModelProtocol {
    
    func getImage() {
        let photoLibraryManager: PhotoLibraryManagerProtocol = PhotoLibraryManager()
        photoLibraryManager.getPermission {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.getImageFromCoordinator()
                case .failure(let error):
                    self.coordinator.showPermissionDeniedAlert(error: error)
                }
            }
        }
    }
    
    func topBarButtonTapped(_ button: DrawingTopBarButton) {
        switch button {
        case .close:
            #warning("show warrning")
            linesInfo.removeAll()
            statePresenter?.render(state: DrawingState.close, mapping: DrawingState.self)
            
        case .undo:
            guard let lastLine = linesInfo.popLast() else { return }
            deletedLines.append(lastLine)
            statePresenter?.render(state: DrawingState.draw(lines: linesInfo),
                                   mapping: DrawingState.self)
        case .redo:
            guard let firstDeletedLine = deletedLines.popLast() else { return }
            linesInfo.append(firstDeletedLine)
            statePresenter?.render(state: DrawingState.draw(lines: linesInfo),
                                   mapping: DrawingState.self)
        case .delete:
            guard currentMode == .drawing, !linesInfo.isEmpty else { return }
            currentMode = .delete
            statePresenter?.render(state: DrawingState.deleteMode(isOn: true),
                                   mapping: DrawingState.self)
    
        case .done:
          break
        }
    }
    
    func doneButtonTapped(imageData: Data?) {
        switch currentMode {
        case .drawing:
            guard let imageData = imageData else { return }
            coordinator.openPreviewView(with: imageData)
            
        case .delete:
            currentMode = .drawing
            statePresenter?.render(state: DrawingState.deleteMode(isOn: false),
                                   mapping: DrawingState.self)
        }
    }
    
    func didTouchImage(at point: CGPoint, eventType: TouchEvent) {
        switch eventType {
        case .began:
            touchBegan(at: point)
        case .moved:
            touchMoved(at: point)
        case .ended:
            touchEnded(at: point)
        }
    }
    
    func bottomBarActionFired(_ action: BottomBarAction) {
        switch action {
        case .slider(let newValue):
            currentThickness = newValue
        case .colorPicker:
            coordinator.colorDidPicked = {[weak self] color in
                guard let self = self else { return }
                self.currentColor = color
                self.statePresenter?.render(state: DrawingState.colorChanged(newColor: color),
                                            mapping: DrawingState.self)
            }
            coordinator.showColorPicker(currentColor: currentColor)
        }
    }
    
}

fileprivate extension DrawingViewModel {
    
    func touchBegan(at point: CGPoint) {
        switch currentMode {
        case .drawing:
            let path = UIBezierPath()
            path.lineWidth = currentThickness
            path.move(to: point)
            let lineInfo = LineInfo(lineColor: currentColor,
                                    lineWidth: currentThickness,
                                    path: path,
                                    pointsCount: 1)
            linesInfo.append(lineInfo)
        case .delete:
            guard currentMode == .delete, !linesInfo.isEmpty else { return }
            for index in 0..<linesInfo.reversed().count {
                if linesInfo[index].path.hasPoint(point, lineWidth: linesInfo[index].lineWidth) {
                    deletedLines.append(linesInfo[index])
                    linesInfo.remove(at: index)
                    statePresenter?.render(state: DrawingState.draw(lines: linesInfo),
                                          mapping: DrawingState.self)
                    break
                }
            }
        }
    }
    
    func touchMoved(at point: CGPoint) {
        guard currentMode == .drawing,
              var lastLine = linesInfo.popLast() else { return }
        lastLine.path.addLine(to: point)
        lastLine.pointsCount = lastLine.pointsCount + 1
        lastLine.isLine = true
        linesInfo.append(lastLine)
        statePresenter?.render(state: DrawingState.draw(lines: linesInfo),
                               mapping: DrawingState.self)
    }
    
    func touchEnded(at point: CGPoint) {
        guard currentMode == .drawing else { return }
        if linesInfo.last?.pointsCount == 1, var lastLine = linesInfo.popLast() {
            lastLine.path = UIBezierPath(ovalIn: CGRect(x: point.x,
                                                        y: point.y,
                                                        width: currentThickness,
                                                        height: currentThickness))
            linesInfo.append(lastLine)
            statePresenter?.render(state: DrawingState.draw(lines: linesInfo),
                                   mapping: DrawingState.self)
        }
    }
}
