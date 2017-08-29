/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import XCTest

class TrackingProtectionTests: BaseTestCase {
    var navigator: Navigator!
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        navigator = createScreenGraph(app).navigator(self)
    }

    override func tearDown() {
        navigator = nil
        app = nil
        super.tearDown()
    }
    
    func testTrackingProtection() {
        navigator.goto(SettingsScreen)
        let appsettingstableviewcontrollerTableviewTable = app.tables["AppSettingsTableViewController.tableView"]
        while app.staticTexts["Tracking Protection"].exists == false {
            appsettingstableviewcontrollerTableviewTable.swipeUp()
        }
        appsettingstableviewcontrollerTableviewTable.staticTexts["Tracking Protection"].tap()
        
        XCTAssertFalse(app.tables.cells["Always On"].isSelected)
        XCTAssertTrue(app.tables.cells["Private Browsing Mode Only"].isSelected)
        XCTAssertFalse(app.tables.cells["Never"].isSelected)
        
        app.tables.cells["Always On"].tap()
        XCTAssertTrue(app.tables.cells["Always On"].isSelected)
        
        app.navigationBars["Tracking Protection"].buttons["Settings"].tap()
        
        waitforExistence(app.navigationBars["Settings"].buttons["Done"])
        app.navigationBars["Settings"]/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".buttons[\"Done\"]",".buttons[\"AppSettingsTableViewController.navigationItem.leftBarButtonItem\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["TabToolbar.menuButton"]/*[[".buttons[\"Menu\"]",".buttons[\"TabToolbar.menuButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let settingsmenuitemCell = app/*@START_MENU_TOKEN@*/.collectionViews.cells["SettingsMenuItem"]/*[[".otherElements[\"MenuViewController.menuView\"].collectionViews",".cells[\"Settings\"]",".cells[\"SettingsMenuItem\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        settingsmenuitemCell.tap()
        
        let appsettingstableviewcontrollerTableviewTable1 = app.tables["AppSettingsTableViewController.tableView"]
        while app.staticTexts["Tracking Protection"].exists == false {
            appsettingstableviewcontrollerTableviewTable1.swipeUp()
        }
        
        appsettingstableviewcontrollerTableviewTable1.staticTexts["Tracking Protection"].tap()
        waitforExistence(app.tables.cells["Always On"])
        
        XCTAssertTrue(app.tables.cells["Always On"].isSelected)
        XCTAssertFalse(app.tables.cells["Private Browsing Mode Only"].isSelected)
        XCTAssertFalse(app.tables.cells["Never"].isSelected)
    }
}
