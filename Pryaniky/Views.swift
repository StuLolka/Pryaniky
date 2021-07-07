//
//  File.swift
//  Pryaniky
//
//  Created by Сэнди Белка on 07.07.2021.
//

import UIKit

final class Views {
    let hzLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    
//    let selector: UISegmentedControl = {
//        let selector = UISegmentedControl()
//        selector.translatesAutoresizingMaskIntoConstraints = false
//        selector.backgroundColor = .systemPink
//        return selector
//    }()
//    
    let pictureView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let hzLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
