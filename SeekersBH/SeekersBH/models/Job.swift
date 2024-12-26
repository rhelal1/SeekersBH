import Foundation

struct JobAd {
    var jobName: String = ""
    var jobLocation: String = ""
    var jobType: JobType = .fullTime
    var jobDescription: String = ""
    var jobKeyResponsibilites: String = ""
    var jobQualifications: String = ""
    var jobSalary: String = ""
    var jobEmploymentBenfits: String = ""
    var additionalPerks: [String] = []
    var jobApplicationDeadline: Date = Date()
    var applicants: [JobApplication] = [] // Array to hold job applicants
    var datePosted: Date = Date() // Date when the job post was added
    var status: status = .Open
    var applicationStatus : ApplicationStatus = .pending
}

enum JobType {
    case fullTime, partTime, contract, temporary
}

enum ApplicationStatus {
    case pending, underReview, shortlisted, interviewScheduled
}

enum status {
    case Closed,Open
}

class JobManager {
    static let shared = JobManager() // Singleton instance
    private init() {} // Prevent external instantiation
    
    var jobs: [JobAd] = []
    
    func printSavedJobs() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium // Use "medium" style for a readable format
           dateFormatter.timeStyle = .none  // Omit the time if you don't want it

           for (index, job) in jobs.enumerated() {
               print("Job \(index + 1):")
               print("Name: \(job.jobName)")
               print("Location: \(job.jobLocation)")
               print("Type: \(job.jobType)")
               print("Description: \(job.jobDescription)")
               print("Key Responsibilities: \(job.jobKeyResponsibilites)")
               print("Qualifications: \(job.jobQualifications)")
               print("Salary: \(job.jobSalary)")
               print("Benefits: \(job.jobEmploymentBenfits)")
               print("Additional Perks: \(job.additionalPerks.joined(separator: ", "))")
               let formattedDate = dateFormatter.string(from: job.jobApplicationDeadline)
               print("Application Deadline: \(formattedDate)")
               print("-------------------------------")
           }
       }
    
}
