import UIKit

class CourseViewController: UIViewController {

    
    @IBOutlet weak var courseTable: UITableView!
    
    let courses: [Course] = [
        Course(
            title: "Introduction to Python Programming",
            rating: 4.8,
            description: "Learn the fundamentals of Python programming, including syntax, data types, and control structures.",
            instructor: "John Doe",
            prerequisites: "Basic understanding of computers.",
            outcomes: "By the end of this course, you will be able to write Python programs, use libraries, and debug code.",
            category: .technology,
            courseComments: [
                CourseComments(userId: 1, username: "JohnDoe", commenttext: "Great course for beginners!", rated: 5),
                CourseComments(userId: 2, username: "JaneSmith", commenttext: "Clear explanations and examples.", rated: 4)
            ],
            courseContent: [
                CourseContent(title: "Python Basics", duration: 30, description: "Introduction to Python syntax and data types.", videoUrl: "https://example.com/video1"),
                CourseContent(title: "Control Flow", duration: 25, description: "Learn about loops, conditions, and functions.", videoUrl: "https://example.com/video2")
            ],
            courseQuestions: [
                question(questionTxt: "What does the `print()` function do?", option1: "Prints to the screen", option2: "Saves data", option3: "Creates a file", option4: "None of the above", correctAnswer: "Prints to the screen", points: 5)
            ]
        ),
        Course(
            title: "Mastering Digital Marketing",
            rating: 4.9,
            description: "A complete guide to digital marketing techniques, including SEO, content marketing, and social media strategies.",
            instructor: "Sarah Miller",
            prerequisites: "No prior knowledge required, but a basic understanding of marketing concepts is beneficial.",
            outcomes: "You will be able to create digital marketing campaigns, optimize websites, and analyze marketing data.",
            category: .business,
            courseComments: [
                CourseComments(userId: 3, username: "SophiaL", commenttext: "A comprehensive course with actionable insights.", rated: 5),
                CourseComments(userId: 4, username: "RyanB", commenttext: "Good course, but I would have liked more examples.", rated: 4)
            ],
            courseContent: [
                CourseContent(title: "SEO Fundamentals", duration: 40, description: "Learn how search engines work and how to optimize your website for them.", videoUrl: "https://example.com/video1"),
                CourseContent(title: "Social Media Marketing", duration: 50, description: "Discover strategies to grow your brand on social media.", videoUrl: "https://example.com/video2")
            ],
            courseQuestions: [
                question(questionTxt: "What does SEO stand for?", option1: "Search Engine Optimization", option2: "Social Engagement Optimization", option3: "Search Engine Organization", option4: "None of the above", correctAnswer: "Search Engine Optimization", points: 5)
            ]
        ),
        Course(
            title: "Introduction to Data Science",
            rating: 4.7,
            description: "Learn how to analyze data, use statistical tools, and work with machine learning algorithms.",
            instructor: "Dr. Emily Watson",
            prerequisites: "Basic knowledge of mathematics and statistics.",
            outcomes: "By the end of this course, you will be able to manipulate data, visualize it, and build machine learning models.",
            category: .technology,
            courseComments: [
                CourseComments(userId: 5, username: "MarkT", commenttext: "This was a great introductory course on data science!", rated: 5),
                CourseComments(userId: 6, username: "TomJ", commenttext: "Could use more practical examples.", rated: 4)
            ],
            courseContent: [
                CourseContent(title: "Data Wrangling", duration: 45, description: "Learn how to clean and prepare data for analysis.", videoUrl: "https://example.com/video1"),
                CourseContent(title: "Introduction to Machine Learning", duration: 60, description: "An overview of machine learning algorithms and their applications.", videoUrl: "https://example.com/video2")
            ],
            courseQuestions: [
                question(questionTxt: "What is a dataset?", option1: "A collection of data", option2: "A type of algorithm", option3: "A graph", option4: "None of the above", correctAnswer: "A collection of data", points: 5)
            ]
        ),
        Course(
            title: "Business Analytics Fundamentals",
            rating: 4.6,
            description: "Learn the basics of business analytics and how to use data to make informed business decisions.",
            instructor: "James Lee",
            prerequisites: "Basic understanding of business concepts.",
            outcomes: "You will be able to analyze business data, create reports, and make data-driven decisions.",
            category: .business,
            courseComments: [
                CourseComments(userId: 7, username: "AliceW", commenttext: "Excellent course! Great for beginners in business analytics.", rated: 5),
                CourseComments(userId: 8, username: "HenryM", commenttext: "Could have more in-depth examples.", rated: 4)
            ],
            courseContent: [
                CourseContent(title: "Introduction to Business Analytics", duration: 50, description: "Learn the role of business analytics in decision making.", videoUrl: "https://example.com/video1"),
                CourseContent(title: "Data-Driven Decision Making", duration: 60, description: "How to analyze data and make business decisions based on insights.", videoUrl: "https://example.com/video2")
            ],
            courseQuestions: [
                question(questionTxt: "What is the main purpose of business analytics?", option1: "To increase sales", option2: "To inform business decisions", option3: "To manage employees", option4: "None of the above", correctAnswer: "To inform business decisions", points: 5)
            ]
        ),
        Course(
            title: "Modern Web Development with React",
            rating: 4.8,
            description: "Learn how to build dynamic, responsive websites using React and modern JavaScript frameworks.",
            instructor: "Michael Brown",
            prerequisites: "Basic knowledge of JavaScript and web development.",
            outcomes: "You will be able to build full-fledged React applications and integrate APIs into your web projects.",
            category: .technology,
            courseComments: [
                CourseComments(userId: 9, username: "SophieL", commenttext: "Great course for getting started with React!", rated: 5),
                CourseComments(userId: 10, username: "DanielK", commenttext: "Covers the basics well, but some topics need more explanation.", rated: 4)
            ],
            courseContent: [
                CourseContent(title: "React Fundamentals", duration: 40, description: "Learn the basics of React, including components and JSX.", videoUrl: "https://example.com/video1"),
                CourseContent(title: "React and APIs", duration: 50, description: "How to fetch and display data from APIs in React.", videoUrl: "https://example.com/video2")
            ],
            courseQuestions: [
                question(questionTxt: "What is JSX in React?", option1: "JavaScript XML", option2: "JavaScript Extension", option3: "JavaScript Execution", option4: "None of the above", correctAnswer: "JavaScript XML", points: 5)
            ]
        ),
        Course(
            title: "Introduction to Economics",
            rating: 4.5,
            description: "Understand the basic principles of economics, including supply and demand, market equilibrium, and fiscal policy.",
            instructor: "Dr. Richard Gray",
            prerequisites: "No prior knowledge required.",
            outcomes: "By the end of this course, you will have a solid understanding of economic concepts and their real-world applications.",
            category: .economics,
            courseComments: [
                CourseComments(userId: 11, username: "LindaR", commenttext: "Excellent foundational course in economics.", rated: 5),
                CourseComments(userId: 12, username: "SteveJ", commenttext: "A bit too theoretical, could use more examples.", rated: 4)
            ],
            courseContent: [
                CourseContent(title: "Supply and Demand", duration: 45, description: "Understanding the laws of supply and demand in the economy.", videoUrl: "https://example.com/video1"),
                CourseContent(title: "Market Structures", duration: 50, description: "Learn about different market structures and their characteristics.", videoUrl: "https://example.com/video2")
            ],
            courseQuestions: [
                question(questionTxt: "What is the law of demand?", option1: "As prices rise, demand decreases", option2: "As prices rise, demand increases", option3: "Demand stays constant regardless of price", option4: "None of the above", correctAnswer: "As prices rise, demand decreases", points: 5)
            ]
        ),
        Course(
            title: "Health and Wellness Fundamentals",
            rating: 4.7,
            description: "Learn about health, fitness, and wellness to improve your overall well-being.",
            instructor: "Dr. Sarah Jones",
            prerequisites: "None.",
            outcomes: "Gain a basic understanding of nutrition, fitness, and mental health practices for a balanced lifestyle.",
            category: .health,
            courseComments: [
                CourseComments(userId: 13, username: "JuliaF", commenttext: "Amazing course! Practical tips for everyday wellness.", rated: 5),
                CourseComments(userId: 14, username: "ChrisM", commenttext: "Good basic introduction to health, but could use more detailed content.", rated: 4)
            ],
            courseContent: [
                CourseContent(title: "Nutrition Basics", duration: 35, description: "Learn about the importance of a balanced diet.", videoUrl: "https://example.com/video1"),
                CourseContent(title: "Exercise and Fitness", duration: 40, description: "A guide to staying fit and active.", videoUrl: "https://example.com/video2")
            ],
            courseQuestions: [
                question(questionTxt: "What is a balanced diet?", option1: "A diet that includes all food groups", option2: "A diet that excludes fats", option3: "A diet that focuses only on protein", option4: "None of the above", correctAnswer: "A diet that includes all food groups", points: 5)
            ]
        ),
        Course(
            title: "Introduction to Machine Learning",
            rating: 4.9,
            description: "Learn the basics of machine learning, including supervised and unsupervised learning techniques.",
            instructor: "Dr. Alex Harris",
            prerequisites: "Basic understanding of Python and statistics.",
            outcomes: "You will be able to build and evaluate machine learning models for a variety of tasks.",
            category: .technology,
            courseComments: [
                CourseComments(userId: 15, username: "LucasG", commenttext: "An excellent introduction to machine learning.", rated: 5),
                CourseComments(userId: 16, username: "EmmaK", commenttext: "Could use more hands-on exercises.", rated: 4)
            ],
            courseContent: [
                CourseContent(title: "Supervised Learning", duration: 50, description: "Learn about regression and classification algorithms.", videoUrl: "https://example.com/video1"),
                CourseContent(title: "Unsupervised Learning", duration: 60, description: "Understand clustering and dimensionality reduction techniques.", videoUrl: "https://example.com/video2")
            ],
            courseQuestions: [
                question(questionTxt: "Which algorithm is used for classification?", option1: "Linear Regression", option2: "K-Nearest Neighbors", option3: "K-Means Clustering", option4: "None of the above", correctAnswer: "K-Nearest Neighbors", points: 5)
            ]
        )
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseTable.dataSource = self
        courseTable.delegate = self
    }
}

extension CourseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseTableViewCell

        cell.update(with: courses[indexPath.row])
        cell.showsReorderControl = true
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Optional: remove separator lines (if not needed)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        cell.preservesSuperviewLayoutMargins = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCourse = courses[indexPath.row]

        // Instantiate the CourseDetailsViewController
        if let courseDetailsVC = storyboard?.instantiateViewController(withIdentifier: "CourseDetailsViewController") as? CourseDetailsViewController {
            // Pass the selected course to the CourseDetailsViewController
            courseDetailsVC.course = selectedCourse

            // Push the detail view controller
            navigationController?.pushViewController(courseDetailsVC, animated: true)
        }
    }
}
