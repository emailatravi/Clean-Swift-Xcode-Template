//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ___VARIABLE_productName:identifier___InteractorProtocol: class {
	var parameters: [String: Any]? { get set }
}

class ___VARIABLE_productName:identifier___Interactor: ___VARIABLE_productName:identifier___InteractorProtocol {
    var presenter: ___VARIABLE_productName:identifier___PresenterProtocol?
    var parameters: [String: Any]?

    init(presenter: ___VARIABLE_productName:identifier___PresenterProtocol) {
    	self.presenter = presenter
    }
}
