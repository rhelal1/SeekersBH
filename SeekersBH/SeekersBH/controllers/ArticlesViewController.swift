import UIKit

class ArticlesViewController: UIViewController {
    
    
    @IBOutlet weak var articleTable: UITableView!
    
    let articles: [Article] = [
        Article(
            title: "Understanding Swift Programming",
            yearOfPublication: 2023,
            publisher: "TechPress",
            DOI: "10.1234/swift2023",
            description: "An in-depth look at Swift programming language and its modern features.",
            shortDescription: "A deep dive into Swift programming.",
            url: "https://techpress.com/swift2023",
            views: 1200
        ),
        Article(
            title: "Introduction to Machine Learning",
            yearOfPublication: 2022,
            publisher: "AI Today",
            DOI: "10.5678/mlintro2022",
            description: "This article introduces the basics of machine learning concepts and algorithms.",
            shortDescription: "Basic concepts of machine learning.",
            url: "https://aitoday.com/mlintro2022",
            views: 2100
        ),
        Article(
            title: "Exploring Quantum Computing",
            yearOfPublication: 2021,
            publisher: "Quantum World",
            DOI: "10.9876/quantum2021",
            description: "Exploring the principles and applications of quantum computing.",
            shortDescription: "An overview of quantum computing.",
            url: "https://quantumworld.com/quantum2021",
            views: 3500
        ),
        Article(
            title: "The Future of Artificial Intelligence",
            yearOfPublication: 2024,
            publisher: "AI Insights",
            DOI: "10.4321/ai_future2024",
            description: "Discussing the future trends and developments in the AI field.",
            shortDescription: "The future of artificial intelligence.",
            url: "https://aiinsights.com/ai_future2024",
            views: 1400
        ),
        Article(
            title: "Data Science for Beginners",
            yearOfPublication: 2023,
            publisher: "Data Today",
            DOI: "10.6543/datascience2023",
            description: "A beginner’s guide to understanding the world of data science and its applications.",
            shortDescription: "A beginner's guide to data science.",
            url: "https://datatoday.com/datascience2023",
            views: 1800
        ),
        Article(
            title: "Advanced Algorithms in Python",
            yearOfPublication: 2022,
            publisher: "Code Academy",
            DOI: "10.8765/algorithms_python2022",
            description: "A comprehensive guide to advanced algorithms implemented in Python.",
            shortDescription: "Advanced Python algorithms.",
            url: "https://codeacademy.com/algorithms_python2022",
            views: 2000
        ),
        Article(
            title: "Blockchain Explained",
            yearOfPublication: 2021,
            publisher: "Tech Innovators",
            DOI: "10.3456/blockchain2021",
            description: "An introductory guide to understanding blockchain technology and its applications.",
            shortDescription: "Understanding blockchain technology.",
            url: "https://techinnovators.com/blockchain2021",
            views: 2300
        ),
        Article(
            title: "Cybersecurity: Threats and Solutions",
            yearOfPublication: 2024,
            publisher: "Cyber World",
            DOI: "10.5432/cybersecurity2024",
            description: "An overview of the current cybersecurity landscape, including the latest threats and defense strategies.",
            shortDescription: "Cybersecurity threats and solutions.",
            url: "https://cyberworld.com/cybersecurity2024",
            views: 1600
        ),
        Article(
            title: "Exploring the Internet of Things",
            yearOfPublication: 2023,
            publisher: "IoT Journal",
            DOI: "10.6542/iot2023",
            description: "A detailed exploration of IoT technology, its use cases, and future potential.",
            shortDescription: "Exploring the Internet of Things.",
            url: "https://iotjournal.com/iot2023",
            views: 1900
        ),
        Article(
            title: "Cloud Computing: The Future of IT",
            yearOfPublication: 2022,
            publisher: "Cloud Tech Magazine",
            DOI: "10.8764/cloudcomputing2022",
            description: "An examination of how cloud computing is transforming the IT landscape.",
            shortDescription: "How cloud computing is shaping the future of IT.",
            url: "https://cloudtechmagazine.com/cloudcomputing2022",
            views: 2200
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        articleTable.dataSource = self
        articleTable.delegate = self
    }
}

extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticlesTableViewCell

        cell.update(with: articles[indexPath.row])
        cell.showsReorderControl = true
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Optional: remove separator lines (if not needed)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        cell.preservesSuperviewLayoutMargins = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let article = articles[indexPath.row]
        
//        navigationController?.pushViewController(ArticleViewController(article: article), animated: true)
    }
}
