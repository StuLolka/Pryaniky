//
//  ExtensionStartViewController.swift
//  Pryaniky
//
//  Created by Сэнди Белка on 08.07.2021.
//

import UIKit

extension StartViewController {
    public func addActionSheetForiPad(actionSheet: UIAlertController) {
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.height * 3/4 , width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
}
