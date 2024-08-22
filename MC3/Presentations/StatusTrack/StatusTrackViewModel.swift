//
//  StatusTrackViewModel.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import Foundation

class StatusTrackViewModel: ObservableObject {
    @Published var isSheetOpened: Bool = false
    @Published var status: Int = 2
}
