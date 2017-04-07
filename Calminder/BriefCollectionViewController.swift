//
//  BriefCollectionViewController.swift
//  Calminder
//
//  Created by saekof on 2017-04-03.
//  Copyright © 2017 saeko0032. All rights reserved.
//

import UIKit

private let reuseIdentifier = "DayCell"
private let headerReuseIdentifier = "WeekHeader"

class BriefCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    @IBOutlet weak var compossBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

        // Register cell classes
   //     collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let kind = UICollectionElementKindSectionHeader
        
      //  collectionView?.register()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
//        if section == 0 {
//            return 7
//        } else {
            let dataManager = DateManager()
            return dataManager.daysForMonth()
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CalendarCell else { return }
        //days
//        cell.dayLabel.text = "1"
    }

    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard let view = view as? WeekHeaderView else { return }
        // nanika
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
    }


    // MARK: IBAction
    @IBAction func tappedAddBtn(sender: UIButton) {
    }
    
    @IBAction func tappedSearchBtn(sender: UIButton) {
    }
    
    @IBAction func tappedCompossBtn(sender: UIButton) {
    }
}
