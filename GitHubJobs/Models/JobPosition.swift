//
//  Job.swift
//  GitHubJobs
//
//  Created by Айдар Рахматуллин on 14.11.2020.
//

struct JobPosition: Decodable {
    let title: String?
    let company: String?
    let location: String?
    let type: String?
    let created_at: String?
    let description: String?
    
    init(with response: [String: Any]) {
        title = response["title"] as? String
        company = response["company"] as? String
        location = response["location"] as? String
        type = response["type"] as? String
        created_at = response["created_at"] as? String
        description = response["description"] as? String
    }
    
    static func getPositions(from response: Any) -> [JobPosition]? {
        var jobPositions: [JobPosition] = []
        
        guard let jobPositionsData  = response as? [[String: Any]] else { return nil }
        for jobPositionData in jobPositionsData {
            let jobPosition = JobPosition(with: jobPositionData)
            jobPositions.append(jobPosition)
        }
        return jobPositions
    }
    
}
