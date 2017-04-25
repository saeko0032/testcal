//
//  TaskTableViewController.swift
//  Calminder
//
//  Created by saekof on 2017-04-21.
//  Copyright © 2017 saeko0032. All rights reserved.
//  thanks: https://github.com/andrewcbancroft/EventTracker/tree/ask-for-permission/EventTracker
//

import UIKit
import EventKit

class TaskTableViewController: UITableViewController {
    let eventStore = EventManager.shared.eventStore
    
    
    
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
    @IBOutlet weak var eventTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkCalendarAuthorizationStatus()
    }

    func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            requestAccessToCalendar()
        case EKAuthorizationStatus.authorized:
            loadCalendars()
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // error?
            needPermissionView.fadeIn()
        }
    }
    
    var calendars: [EKCalendar]?
    
    // ...
    
    func loadCalendars() {
        self.calendars = eventStore.calendars(for: EKEntityType.event)
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    @IBAction func addEventBtnTapped(_ sender: UIBarButtonItem) {
//        if let calendarForEvent = eventStore.calendar(withIdentifier: <#T##String#>)
    }
}
