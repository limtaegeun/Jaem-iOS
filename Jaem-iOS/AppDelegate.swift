//
//  AppDelegate.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 21..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift

var RealmSchemaVersion: UInt64 = 15


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        realmMigration()
        
        //getListOfFont()
        /*
        let backButtonImage = JaemIconStyleKit.imageOfExitBlackArrow.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        UIBarButtonItem.appearance().setBackButtonBackgroundImage( backButtonImage, forState : UIControlState.Normal   ,barMetrics: UIBarMetrics.Default )
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, backButtonImage.size.height * 3), forBarMetrics: .Default)
        */
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func realmMigration() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: RealmSchemaVersion,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < RealmSchemaVersion) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        _ = try! Realm()
    }
    
    func getListOfFont() {
        let fontFamilies = UIFont.familyNames()
        for i in fontFamilies {
            let fontFamily = i
            let fontName = UIFont.fontNamesForFamilyName(i)
            print("fontFamily:" + fontFamily   )
            print(fontName)
        }
    }
    
    
    
}

