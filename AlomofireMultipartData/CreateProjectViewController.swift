//
//  CreateProjectViewController.swift
//  AlomofireMultipartData
//
//  Created by Elorce on 28/04/22.
//

import UIKit

class CreateProjectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createNewProject()
    }
    
    func createNewProject() {
        
        var parameters: [String : Any] = [
            "mentor_project_status" : "pending"
        ]
        
        if let _basicSignID = Constants.getBasicSignId() {
            parameters["basic_sign_id"] = _basicSignID
        }
        
        //if let _researchTitle = LBRSingleton.shared.mentorNewProjectM?.researchTitle {
            parameters["research_title"] = "Science Project"
        //}
        
        //if let _areaOfInterestName = LBRSingleton.shared.mentorNewProjectM?.areaOfInterest?.areaOfInterestName {
            parameters["area_of_interest_name"] = "AI, ML & DL"
        //}
        
        //if let _areaOfInterestID = LBRSingleton.shared.mentorNewProjectM?.areaOfInterest?.areaOfInterestID {
            parameters["area_of_interest_id"] = "1"
        //}
        
        //if let _dueDate = LBRSingleton.shared.mentorNewProjectM?.dueDate {
            parameters["research_aplctn_due_date"] = "1651257000000"
        //}
        
        //if let _objOfResearc = LBRSingleton.shared.mentorNewProjectM?.objOfResearch {
            parameters["research_objective"] = "Hello world"
        //}
        
        //if let _despOfResearch = LBRSingleton.shared.mentorNewProjectM?.despOfResearch {
            parameters["research_description"] = "Hello world"
        //}
        
        //if let _outcomeOfResearch = LBRSingleton.shared.mentorNewProjectM?.outcomeOfResearch {
            parameters["research_outcome"] = "Hello world"
       // }
        
        //if let _lbrTeamRequirementModelArr = LBRSingleton.shared.mentorNewProjectM?.lbrTeamRequirementModelArr {
            let index = 0
            //for teamRequirementM in _lbrTeamRequirementModelArr {
                parameters["research_team_requirements[\(index)][position_title]"] = "Hello world"
                parameters["research_team_requirements[\(index)][id]"] = index + 1
                parameters["research_team_requirements[\(index)][team_size]"] = "4"
                parameters["research_team_requirements[\(index)][eligibility_criterion]"] = "Hello world"
                parameters["research_team_requirements[\(index)][metrics_to_measure]"] = "Hello world"
                parameters["research_team_requirements[\(index)][skills_needed]"] = "Hello world"
               // index += 1
           // }
        //}
        
        //if let _totalDuration =  LBRSingleton.shared.mentorNewProjectM?.totalDuration {
            parameters["research_duration_months"] = "3"
        //}
        
        //if let _weeklyCommitments = LBRSingleton.shared.mentorNewProjectM?.weeklyCommitments {
            parameters["research_wkly_cmtmnt_hrs"] = "3"
        //}
        
//        if let _lbrMentorNewPrjctMilestonesModelArr = LBRSingleton.shared.mentorNewProjectM?.lbrMentorNewPrjctMilestonesModelArr {
            let research_milestonesindex = 0
//            for mentorNewPrjctMilestonesM in _lbrMentorNewPrjctMilestonesModelArr {
                parameters["research_milestones[\(index)][title]"] = "Hello world"
                parameters["research_milestones[\(index)][id]"] = research_milestonesindex + 1
                parameters["research_milestones[\(index)][status]"] = 0
                parameters["research_milestones[\(index)][date_time]"] = "1651257000000"
                parameters["research_milestones[\(index)][description]"] = "Hello world"
//                index += 1
//            }
//        }
        
//        if let _mentorNewProjectReferenceModelArr = LBRSingleton.shared.mentorNewProjectM?.mentorNewProjectReferenceModelArr {
            let Referenceindex = 0
//            for MmntorNewProjectReferenceM in _mentorNewProjectReferenceModelArr {
                parameters["research_reference_link[\(Referenceindex)]"] = "google.com"
//                index += 1
//            }
//        }
        
        let img = UIImage.init(named: "iter")
        let imgM:ImageModel = ImageModel(img: img!, imgName: "imgNname")
        //if let _imgM = LBRSingleton.shared.mentorNewProjectM?.imgM {
            parameters["research_banner_path"] = "imgNname.png"
            //imgM = _imgM
        //}
        
        
        MentorProjectManagementRequests.createNewProjectRequestWith(WithParameters: parameters, WithImageModel: imgM, ForResultType: MentorNewProjectResponseModel.self) { (responseM, errIs) in
            //LBRProgressHud.hideHUD()
            if let _ = errIs {
                //self.failedToCreateNewProjectCallBack?(_errIs.localizedDescription)
                print("Failed to create")
            } else if let _ = responseM {
                print("Created project")
                //if let status = _responseM.status, status == true, let successMsg = _responseM.message   {
                    //self.successfullyCreatedNewProjectCallBack?(successMsg)
                //} else if let status = _responseM.status, status == false {
                    //self.failedToCreateNewProjectCallBack?(_responseM.message ?? "")
                //}
            }
        }
    }
    
}
