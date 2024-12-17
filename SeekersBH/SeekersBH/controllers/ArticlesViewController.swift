import UIKit

class ArticlesViewController: UIViewController {
    
    
    @IBOutlet weak var articleTable: UITableView!
    
    let articles: [Article] = [
        Article(
            title: "Understanding Swift Programming",
            author: "John Doe",
            yearOfPublication: 2023,
            publisher: "TechPress",
            DOI: "10.1234/swift2023",
            description: """
            Swift is a modern, high-performance programming language developed by Apple for building iOS, macOS, watchOS, and tvOS applications. In this article, we take an in-depth look at Swift’s advanced features, including its strong typing, error handling, and the new concurrency model introduced in Swift 5.5. We also explore its integration with Apple's ecosystem and why it’s the go-to language for developers building native apps for Apple platforms.
            """,
            url: "https://techpress.com/swift2023",
            views: 1200
        ),
        Article(
            title: "Introduction to Machine Learning",
            author: "Jane Smith",
            yearOfPublication: 2022,
            publisher: "AI Today",
            DOI: "10.5678/mlintro2022",
            description: """
                Machine learning is revolutionizing industries by enabling systems to automatically learn and improve from experience without explicit programming. This article introduces the foundational concepts of machine learning, including supervised and unsupervised learning, and explores popular algorithms such as linear regression, decision trees, and neural networks. We also provide insights into the practical applications of machine learning in fields like healthcare, finance, and marketing.
            """,
            url: "https://aitoday.com/mlintro2022",
            views: 2100
        ),
        Article(
            title: "Exploring Quantum Computing",
            author: "Alice Johnson",
            yearOfPublication: 2021,
            publisher: "Quantum World",
            DOI: "10.9876/quantum2021",
            description: """
                Quantum computing is poised to change the world of computing by harnessing the power of quantum mechanics to solve problems that classical computers cannot. This article delves into the principles of quantum computing, including quantum bits (qubits), superposition, entanglement, and quantum gates. We also examine current quantum computing platforms, the challenges in developing stable quantum systems, and the promising applications in fields like cryptography, material science, and optimization.
            """,
            url: "https://quantumworld.com/quantum2021",
            views: 3500
        ),
        Article(
            title: "The Future of Artificial Intelligence",
            author: "Michael Brown",
            yearOfPublication: 2024,
            publisher: "AI Insights",
            DOI: "10.4321/ai_future2024",
            description: """
                Artificial intelligence is rapidly evolving, with breakthroughs in deep learning, reinforcement learning, and natural language processing. This article explores the future of AI, discussing trends such as AI ethics, the role of AI in the workforce, and its impact on decision-making processes across industries. We also look at emerging technologies like explainable AI and AI-driven automation, and how they will shape the future of work and society at large.
            """,
            url: "https://aiinsights.com/ai_future2024",
            views: 1400
        ),
        Article(
            title: "Data Science for Beginners",
            author: "Emily White",
            yearOfPublication: 2023,
            publisher: "Data Today",
            DOI: "10.6543/datascience2023",
            description: """
                Data science is one of the most in-demand skills today, blending mathematics, statistics, and computer science to analyze and interpret complex data. This beginner's guide offers a clear and concise introduction to the field, covering essential topics like data cleaning, exploratory data analysis, and machine learning algorithms. We also provide practical tips on how to get started with popular tools such as Python, R, and SQL, as well as resources for further learning.
            """,
            url: "https://datatoday.com/datascience2023",
            views: 1800
        ),
        Article(
            title: "Advanced Algorithms in Python",
            author: "Chris Green",
            yearOfPublication: 2022,
            publisher: "Code Academy",
            DOI: "10.8765/algorithms_python2022",
            description: """
                In this article, we dive deep into advanced algorithms implemented in Python, focusing on optimization techniques and solving complex problems efficiently. Topics include dynamic programming, graph algorithms, advanced sorting algorithms, and techniques for handling large-scale data. With clear explanations and Python code examples, this guide is perfect for developers looking to strengthen their algorithmic problem-solving skills and improve the performance of their applications.
            """,
            url: "https://codeacademy.com/algorithms_python2022",
            views: 2000
        ),
        Article(
            title: "Blockchain Explained",
            author: "Daniel Harris",
            yearOfPublication: 2021,
            publisher: "Tech Innovators",
            DOI: "10.3456/blockchain2021",
            description: """
            Blockchain technology underpins cryptocurrencies like Bitcoin, but its applications extend far beyond digital currency. In this article, we break down the fundamentals of blockchain, including how decentralized networks, consensus algorithms, and cryptographic hashing work. We also explore the various use cases of blockchain technology, from supply chain management and voting systems to its potential in healthcare and finance.
            """,
            url: "https://techinnovators.com/blockchain2021",
            views: 2300
        ),
        Article(
            title: "Cybersecurity: Threats and Solutions",
            author: "Sophia Lee",
            yearOfPublication: 2024,
            publisher: "Cyber World",
            DOI: "10.5432/cybersecurity2024",
            description: """
            With the increasing sophistication of cyber threats, protecting sensitive data and systems has become more critical than ever. This article covers the latest cybersecurity challenges, including ransomware, phishing, and insider threats. We also delve into solutions such as multi-factor authentication, encryption, and artificial intelligence-driven security tools that are helping organizations defend against modern cyberattacks.
            """,
            url: "https://cyberworld.com/cybersecurity2024",
            views: 1600
        ),
        Article(
            title: "Exploring the Internet of Things",
            author: "David Kim",
            yearOfPublication: 2023,
            publisher: "IoT Journal",
            DOI: "10.6542/iot2023",
            description: """
            The Internet of Things (IoT) is transforming how we interact with the world around us, enabling devices to communicate and exchange data in real-time. This article takes a detailed look at IoT technology, including its architecture, sensors, and communication protocols. We also examine the potential applications of IoT in areas such as smart homes, healthcare, transportation, and agriculture, as well as the challenges of security and data privacy.
            """,
            url: "https://iotjournal.com/iot2023",
            views: 1900
        ),
        Article(
            title: "Cloud Computing: The Future of IT",
            author: "Olivia Martinez",
            yearOfPublication: 2022,
            publisher: "Cloud Tech Magazine",
            DOI: "10.8764/cloudcomputing2022",
            description: """
                Cloud computing is radically changing the IT landscape by offering scalable, flexible, and cost-efficient infrastructure. This article explores how cloud platforms like AWS, Azure, and Google Cloud are shaping the future of computing, from hosting applications to providing on-demand storage and computing power. We also look at the challenges of cloud migration, data security, and the rise of hybrid and multi-cloud architectures.
            """,
            url: "https://cloudtechmagazine.com/cloudcomputing2022",
            views: 2200
        )
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetch resources
        FirebaseManager.shared.fetchResources(ofType: .article) { articles, error in
                    if let error = error {
                        print("Error fetching articles: \(error.localizedDescription)")
                    } else if let articles = articles as? [Article] {
                        for article in articles {
                            print("Title: \(article.title), Author: \(article.author), Views: \(article.views)")
                        }
                    }
        }
        
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
        return 170
    }
    
    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.row]

        // Instantiate the ArticleDetailsViewController
        if let articleDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as? ArticleDetailsViewController {
            // Pass the selected article to the ArticleDetailsViewController
            articleDetailsVC.article = selectedArticle

            // Push the detail view controller
            navigationController?.pushViewController(articleDetailsVC, animated: true)
        }
    }
}
