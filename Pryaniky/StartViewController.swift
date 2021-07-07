//
//  ViewController.swift
//  Pryaniky
//
//  Created by Сэнди Белка on 07.07.2021.
//

import UIKit

class StartViewController: UIViewController {
    
    private let views = Views()
    private let networkManager = NetworkManager()
    private var nameArray = [String]()
    
    lazy private var state = ViewsDidTap.turnOff {
        didSet {
            switch state {
            case .hz:
                print("nameArray[0] = \(nameArray[0])")
                getAlert(text: nameArray[0])
            case .image:
                print("nameArray[1] = \(nameArray[1])")
                getAlert(text: nameArray[1])
            case .turnOff:
                return
            }
        }
    }
    
    lazy var hzLabel1 = views.hzLabel1
    
    lazy var pictureView = views.pictureView
    
    lazy var hzLabel2 = views.hzLabel2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addConstraints()
        addTaps()
        networkManager.fetchData() { data in
            self.addDataToView(data: data)
        }
    }
    
    private func addTaps() {
        let tapHZ1 = UITapGestureRecognizer(target: self, action: #selector(hzWasTapped))
        hzLabel1.isUserInteractionEnabled = true
        hzLabel1.addGestureRecognizer(tapHZ1)
        
        let tapHZ2 = UITapGestureRecognizer(target: self, action: #selector(hzWasTapped))
        hzLabel2.isUserInteractionEnabled = true
        hzLabel2.addGestureRecognizer(tapHZ2)
        
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(imageWasTapped))
        pictureView.isUserInteractionEnabled = true
        pictureView.addGestureRecognizer(tapImage)
    }
    
    private func addDataToView(data: NetworkModel) {
        DispatchQueue.main.async {
            self.hzLabel1.text = data.data[0].data.text
            self.hzLabel2.text = data.data[0].data.text
            
            self.addNameInArray(data: data.data)
            
            if let text1 = data.data[2].data.variants?[0].text, let text2 = data.data[2].data.variants?[1].text, let text3 = data.data[2].data.variants?[2].text {
                let items = [text1, text2, text3]
                let selector = UISegmentedControl(items: items)
                self.addSelector(selector: selector)
                if let selectedID = data.data[2].data.selectedId, let variants = data.data[2].data.variants{
                    self.getSelectedSegment(id: selectedID, variants: variants, selector: selector)
                }
                if let url = data.data[1].data.url {
                    self.pictureView.loadImageFromURL(url: url)
                }
            }
        }
    }
    
    private func addNameInArray(data: [DataModel]) {
        var i = 0
        while i < data.count {
            nameArray.append(data[i].name)
            i += 1
        }
    }
    
    private func getSelectedSegment(id: Int, variants: [Variants], selector: UISegmentedControl) {
        var i = 0
        while i < variants.count {
            if variants[i].id == id {
                selector.selectedSegmentIndex = i
            }
            i += 1
        }
    }
    
    private func addSelector(selector: UISegmentedControl) {
        view.addSubview(selector)
        selector.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selector.bottomAnchor.constraint(equalTo: pictureView.topAnchor, constant: -35),
            selector.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selector.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            selector.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            selector.heightAnchor.constraint(equalToConstant: view.bounds.height / 25)
        ])
    }
    
    private func addConstraints() {
        view.addSubview(hzLabel1)
        view.addSubview(pictureView)
        view.addSubview(hzLabel2)
        NSLayoutConstraint.activate([
            hzLabel1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hzLabel1.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height / 4),
            
            pictureView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pictureView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pictureView.widthAnchor.constraint(equalToConstant: view.bounds.width / 3),
            pictureView.heightAnchor.constraint(equalTo: pictureView.widthAnchor),
            
            hzLabel2.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 35),
            hzLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func hxTestWasTapped() {
        print("4e za nahoi")
        state = .hz
    }
    
    @objc func hzWasTapped() {
        print(nameArray)
        state = .hz
    }

    @objc func imageWasTapped() {
        print(nameArray)
        state = .image
    }
    
    @objc func getAlert(text: String) {
        print("??????")
        let alertController = UIAlertController(title: "Name this view: \(text)", message: "", preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

enum ViewsDidTap {
    case hz
    case image
    case turnOff
}
