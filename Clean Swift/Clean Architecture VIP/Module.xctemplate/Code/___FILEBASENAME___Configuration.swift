//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

class ___VARIABLE_productName:identifier___Configuration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = ___VARIABLE_productName:identifier___ViewController()
        let router = ___VARIABLE_productName:identifier___Router(view: controller)
        let presenter = ___VARIABLE_productName:identifier___Presenter(view: controller)
        let interactor = ___VARIABLE_productName:identifier___Interactor(presenter: presenter)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}