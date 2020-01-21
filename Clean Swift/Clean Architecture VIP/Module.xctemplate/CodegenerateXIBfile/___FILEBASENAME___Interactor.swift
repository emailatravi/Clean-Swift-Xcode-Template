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

	func doSomething(requestModel: ___VARIABLE_productName:identifier___Model.RequestModel)
}

class ___VARIABLE_productName:identifier___Interactor {
    var presenter: ___VARIABLE_productName:identifier___PresenterProtocol?
    var parameters: [String: Any]?

    init(presenter: ___VARIABLE_productName:identifier___PresenterProtocol) {
    	self.presenter = presenter
    }
}

extension ___VARIABLE_productName:identifier___Interactor: ___VARIABLE_productName:identifier___InteractorProtocol {
    func doSomething(requestModel: ___VARIABLE_productName:identifier___Model.RequestModel) {
        // do something...
        let responseModel = ___VARIABLE_productName:identifier___Model.ResponseModel()
        presenter?.presentSomething(responseModel: responseModel)
    }
}
