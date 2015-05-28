//
//  ViewController.swift
//  ChronoSlide
//
//  Created by Tim Harris on 9/29/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

import UIKit

let AddingNewAlarmNotification:String = "AddingNewAlarmNotification"


class ViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    var alarmList:[Alarms] = [Alarms]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addingNewAlarm:", name: AddingNewAlarmNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addingNewAlarm(notification:NSNotification){
        var dict = notification.userInfo!
        self.alarmList.append(dict["alarm"]! as Alarms)
        //println(self.alarmList)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:AlarmTableCell = tableView.dequeueReusableCellWithIdentifier("AlarmCell", forIndexPath: indexPath) as AlarmTableCell
        
        cell.AlarmTimeLabel.text = self.alarmList[indexPath.row].timeString()
        var leftSwipe:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "leftSwipeAction:")
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        leftSwipe.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(leftSwipe)
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alarmList.count
    }
    
    func leftSwipeAction(gesture:UISwipeGestureRecognizer){
        //do logic stuff
        var swipeLocation:CGPoint = gesture.locationInView(self.tableView)
        var indexPath:NSIndexPath = self.tableView.indexPathForRowAtPoint(swipeLocation)!
        
        var alarm:Alarms = self.alarmList[indexPath.row]
        alarm.activeState = !alarm.activeState
        
        var alarmCell:AlarmTableCell = self.tableView.cellForRowAtIndexPath(indexPath) as AlarmTableCell
        if alarm.activeState {
            //visual stuff for activate
            var animation1:CABasicAnimation = CABasicAnimation(keyPath: "activateGreen")
            var cgPointMove: CGPoint = CGPoint(x: alarmCell.layer.position.x-20, y: alarmCell.layer.position.y)
            animation1.fromValue = alarmCell.layer.valueForKey("position")
            animation1.toValue = NSValue(CGPoint: cgPointMove)
            alarmCell.layer.position = cgPointMove
            alarmCell.layer.addAnimation(animation1, forKey: "position")
            /*
            var filterLayer:CAGradientLayer = CAGradientLayer()
            filterLayer.startPoint = CGPoint(x: alarmCell.layer.position.x, y: alarmCell.layer.position.y)
            filterLayer.endPoint = CGPoint(x: alarmCell.layer.frame.width, y: alarmCell.layer.position.y)
            var color1:UIColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.0)
            var color2:UIColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
            filterLayer.colors = [color1,color2]
            */
            //alarmCell.layer.filters.append(filterLayer)
            }else{
            //visual stuff for not activated
        }
        
    }
}


class AlarmViewController: UIViewController {


    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var deleteButtonObject: UIButton!
    var newAlarm:Alarms = Alarms()
    

    @IBAction func saveAlarm(sender: AnyObject) {
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        //print(dateFormatter.stringFromDate(alarmDatePicker.date))
        newAlarm.alarmDate = alarmDatePicker.date
        
        
        
        //place newAlarm in alarmlist
        NSNotificationCenter.defaultCenter().postNotificationName(AddingNewAlarmNotification, object: self, userInfo: ["alarm": newAlarm])
        
        performSegueWithIdentifier("backToList", sender: self)
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.deleteButtonObject.hidden = true
        self.navigationItem.title = "New Alarm"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


class AlarmTableCell: UITableViewCell {
    
    @IBOutlet weak var AlarmTimeLabel: UILabel!
}
