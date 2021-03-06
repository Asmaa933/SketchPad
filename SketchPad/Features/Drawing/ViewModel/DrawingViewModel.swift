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
    private var currentColor: UIColor = .black
    private var currentThickness: CGFloat = 20
    private var sketch: Sketch?
    private lazy var deletedLines = [LineInfo]() {
        didSet {
            checkButtonsAppear(checkedArr: deletedLines, buttons: [.redo])
        }
    }
    
    private lazy var linesInfo = [LineInfo]() {
        didSet {
            checkButtonsAppear(checkedArr: linesInfo, buttons: [.undo, .delete])
        }
    }
    
    private var currentMode: Mode = .drawing {
        didSet {
            statusChanged()
        }
    }
    
    var statePresenter: StatePresentable?
    
    init(coordinator: DrawingCoordinatorProtocol) {
        self.coordinator = coordinator
        observeOnEditNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

fileprivate extension DrawingViewModel {
    
    func getImageFromCoordinator() {
        coordinator.imageDidPicked = {[weak self] sketch in
            guard let self = self else { return }
            self.updateSketch(sketch)
        }
        coordinator.showImagePicker()
    }
    
    func updateSketch(_ sketch: Sketch) {
        guard let imageData = sketch.imageData else { return }
        self.sketch = sketch
        self.statePresenter?.render(state: .imagePicked(imageData: imageData),
                                    mapping: DrawingState.self)
    }
    
    func observeOnEditNotification() {
        let notificationName = NotificationName.editImage.rawValue
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receivedEditNotification(_:)),
                                               name: NSNotification.Name(rawValue: notificationName),
                                               object: nil)
    }
    
    @objc func receivedEditNotification(_ notification: Notification) {
        guard let sketchDict = notification.userInfo,
              let sketch = sketchDict.decodeJSON(mappingClass: Sketch.self) else { return }
        updateSketch(sketch)
    }
    
    func checkButtonsAppear(checkedArr: [LineInfo], buttons: [DrawingTopBarButton]) {
        var hiddenButtons = [DrawingTopBarButton]()
        var notHiddenButtons = [DrawingTopBarButton]()
        if checkedArr.isEmpty  {
            hiddenButtons = buttons
            notHiddenButtons = []
        } else {
            hiddenButtons = []
            notHiddenButtons = buttons
        }
        
        let state = DrawingState.shouldChangeHidden(hiddenButtons: hiddenButtons, notHiddenButtons: notHiddenButtons)
        statePresenter?.render(state: state, mapping: DrawingState.self)
        
    }
    
    func statusChanged() {
        switch currentMode {
        case .drawing:
            checkButtonsAppear(checkedArr: linesInfo, buttons: [.undo, .delete])
        case .delete:
            statePresenter?.render(state: DrawingState.deleteMode(isOn: true), mapping: DrawingState.self)
            
            let hideState = DrawingState.shouldChangeHidden(hiddenButtons: [.delete, .undo, .redo],
                                                            notHiddenButtons: [])
            statePresenter?.render(state: hideState, mapping: DrawingState.self)
        }
    }
    
    func showPermissionDeniedAlert() {
        let settingsAction = UIAlertAction(title: TitleConstant.openSettings.rawValue, style: .destructive) {[weak self] _ in
            guard let self = self else { return }
            self.openSettings()
        }
        
        let okAlert = UIAlertAction(title: TitleConstant.ok.rawValue, style: .default)
        coordinator.showAlert(error: .photoPermissionDenied,
                              actions: [okAlert, settingsAction])
    }
    
    func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsURL) else { return }
        UIApplication.shared.open(settingsURL)
    }
    
    func showCloseAlert() {
        let closeAction = UIAlertAction(title: TitleConstant.close.rawValue,
                                        style: .destructive) {[weak self] _ in
            guard let self = self else { return }
            self.closeDrawing()
        }
        let cancelAction = UIAlertAction(title: TitleConstant.cancel.rawValue,
                                         style: .default)
        coordinator.showAlert(error: .confirmClose,
                              actions: [closeAction, cancelAction])
    }
    
    func closeDrawing() {
        statePresenter?.render(state: DrawingState.close,
                               mapping: DrawingState.self)
        resetData()
    }
    
    func resetData() {
        linesInfo.removeAll()
        deletedLines.removeAll()
        currentMode = .drawing
        currentColor = .black
        currentThickness = 20
        sketch = nil
    }
}

extension DrawingViewModel: DrawingViewModelProtocol {
    
    func getImage() {
        let photoLibraryManager: PhotoLibraryManagerProtocol = PhotoLibraryManager()
        if photoLibraryManager.permissionIsDenied() {
            showPermissionDeniedAlert()
        } else {
            getImageFromCoordinator()
        }
    }
    
    func topBarButtonTapped(_ button: DrawingTopBarButton) {
        switch button {
        case .close:
            showCloseAlert()
            
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
            
        case .done:
            break
        }
    }
    
    func doneButtonTapped(imageData: Data?) {
        switch currentMode {
        case .drawing:
            guard var sketch = sketch,
                  let imageData = imageData else { return }
            sketch.imageData = imageData
            coordinator.openPreviewView(with: sketch)
            
        case .delete:
            currentMode = .drawing
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
