//
//  SearchDispatcher.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 12/06/2022.
//

import Foundation

protocol SearchDispatcher {
    func call(_ request: @escaping () -> Void)
}

class SearchDispatchItem: SearchDispatcher {
    
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    func call(_ request: @escaping () -> Void) {
        pendingRequestWorkItem?.cancel()
        let requestWorkItem = DispatchWorkItem {
            request()
        }
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
                                      execute: requestWorkItem)
    }
}
