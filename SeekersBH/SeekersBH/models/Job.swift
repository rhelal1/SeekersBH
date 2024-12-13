import Foundation

struct JobAd {
    var jobName : String
    var jobLocation : String
    var jobType : JobType
    var jobDescription : String
    var jobKeyResponsibilites : String
    var jobQualifications : String
    var jobSalary : Int
    var jobEmploymentBenfits : String
    var AdditionalPerks : [String]
    var jobApplicationDeadline : Date
}


enum JobType {
    case fullTime
    case parTime
    case contract
    case temporary
}
