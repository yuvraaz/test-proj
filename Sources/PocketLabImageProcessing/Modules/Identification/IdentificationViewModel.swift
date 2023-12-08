//
//  IdentificationViewModel.swift
//
//
//  Created by Amrit Duwal on 12/8/23.
//

import Foundation


public class IdentificationViewModel: BaseViewModel, ObservableObject {
    
    @Published public var isBusy = false
     
    public var showAlert: Bool?
    public var showSuccessAlert: Bool = false
    
    public func getData() {
        isBusy = true
        if environment == .development {
            self.isBusy = false
            return
        }
    
    }
    
}
