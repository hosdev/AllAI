//
//  OnboardingDataModel.swift
//  AllAI
//
//  Created by hosam abufasha on 23/02/2024.
//

import Foundation


class OnboardingModel {
    
    init(datasource: HttpClient) {
        self.datasource = datasource
    }
    
    //MARK: - Properties
    let urlConfig = HttpUrlConfig(scheme: AppConfig.scheme, host: AppConfig.host)
    let datasource : HttpClient

    //MARK: - Methods
    func getOnboardingListAction() async -> ApiResponse<[Onboarding]>{
        let task =  await Task{
            let result = await datasource.call(
                config: urlConfig,
                path: "/api/v1/onboarding-screens",
                method: .get
            )
            switch result {
            case .success(let success):
                return ApiResponseHandler<[Onboarding]>.handleResponse(data:success.data, response: success.response)
            case .failure(let failure):
                return .init(status: .failed(failure))
            }
        }.value
        return  task
    }
    
    
}
