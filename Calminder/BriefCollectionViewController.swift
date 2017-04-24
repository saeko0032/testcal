//
//  BriefCollectionViewController.swift
//  Calminder
//
//  Created by saekof on 2017-04-03.
//  Copyright © 2017 saeko0032. All rights reserved.
//

import UIKit
import EventKit

private let reuseIdentifier = "DayCell"
private let headerReuseIdentifier = "WeekHeader"

class BriefCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let dateManager = DateManager()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    @IBOutlet weak var compossBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // day part is a header, so I need only 1 section for days
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // ex)April->30 Feb->28
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateManager.cellsForMonth()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard cell is CalendarCell else {
            return
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CalendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CalendarCell

        let firstDayPosition: Int = dateManager.ordinalityOfFirstDay() - 1
        let endDayPosition: Int = firstDayPosition + dateManager.daysForMonth() - 1
        print(endDayPosition)
        // coloring except this month's cell
        if indexPath.row < firstDayPosition || endDayPosition < indexPath.row {
            cell.backgroundColor = UIColor(red: 0.9765, green: 0.9765, blue: 0.9765, alpha: 0.7)
            cell.dayLabel.textColor = UIColor(red: 0.8588, green: 0.8588, blue: 0.8588, alpha: 1.0)
        } else if indexPath.row % 7 == 0 {
            // Sunday
            cell.dayLabel.textColor = UIColor.red
        } else if indexPath.row % 7 == 6 {
            // Saturday
            cell.dayLabel.textColor = UIColor.blue
        } else {
            // Weekday
            cell.dayLabel.textColor = UIColor.darkGray
        }
        // what the date today
        cell.dayLabel.text = dateManager.conversionDateFormat(indexPath: indexPath as NSIndexPath)
        

        
//        while (indexPath.row < firstDayPosition) {
//            cell.backgroundColor = UIColor.red
//            break;
//        }
        
        return cell
    }
    
   func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
    }


    @IBAction func tappedSearchBtn(sender: UIButton) {
        
    }
    
    @IBAction func tappedCompossBtn(sender: UIButton) {
    
    }
}
