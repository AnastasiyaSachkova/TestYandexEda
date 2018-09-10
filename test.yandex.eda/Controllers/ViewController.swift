//
//  ViewController.swift
//  test.yandex.eda
//
//  Created by MacMini Elis on 07/09/2018.
//  Copyright © 2018 MacMini Build. All rights reserved.
//

import UIKit
import Unbox

class ViewController: UIViewController, ActivityProtocol  {
    @IBOutlet weak var tableView: TableAutoDemension!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    private var model: PlaceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        segmentedControl.selectedSegmentIndex = 0
        startActivity()
        getPlaces()
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
    
    func getPlaces() {
        NetworkApi.performRequestWithCallBack(request: NetworkApi.urlRequest()) {[weak self] dict in
            do{
                self?.model = try unbox(dictionary: dict as UnboxableDictionary)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print(error)
            }
            
        }
    }
    
    deinit {
        print("deinit - ViewController")
    }
    
}
//MARK: - TableView DataSource Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.foundPlaces.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PlacesTVC = tableView.dequeueReusableCell(withIdentifier: "PlacesTVC") as! PlacesTVC
        if let item = model?.foundPlaces[indexPath.row] {
            cell.setData(with: item)
            stopActivity()
        }
        return cell
        
    }
}

