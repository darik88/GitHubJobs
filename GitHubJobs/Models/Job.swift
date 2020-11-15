//
//  Job.swift
//  GitHubJobs
//
//  Created by Айдар Рахматуллин on 14.11.2020.
//

struct Job: Decodable {
    let title: String?
    let company: String?
    let location: String?
    let type: String?
    let created_at: String?
    let description: String?
}
