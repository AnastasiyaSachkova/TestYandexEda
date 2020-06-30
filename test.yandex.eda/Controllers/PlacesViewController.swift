//
//  ViewController.swift
//  test.yandex.eda
//
//  Created by MacMini Elis on 07/09/2018.
//  Copyright © 2018 MacMini Build. All rights reserved.
//

import UIKit

class PlacesViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: TableAutoDemension!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //MARK: - Variables
    // private var model: PlaceModel?
    private var placesData: PlacesDataProvider!
    
    //MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        //segmentedControl.selectedSegmentIndex = 0
        //startActivity()
        //getPlaces()
    }
    
    
    private func setupTableView() {
        tableView.delegate = placesData
        tableView.dataSource = placesData
    }
    
    @IBAction func switchSegmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: Cacher.shared.cacheType = .sdwebimage
        case 1: Cacher.shared.cacheType = .kingfisher
        case 2: Cacher.shared.cacheType = .nuke
        case 3: Cacher.shared.cacheType = .undefind
        default: break
        }
        tableView.reloadData()
    }
    
    deinit {
        print("deinit - ViewController")
    }
    
}


