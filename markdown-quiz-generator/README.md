# Markdown Quiz Generator

<div align="center">
  <p><strong>Convert your Markdown files into interactive quizzes</strong></p>
</div>

## 🚀 Introduction

The Markdown Quiz Generator is a powerful tool that allows you to create interactive quizzes from simple Markdown files. This means you can leverage all the formatting capabilities of Markdown - including structured text, bold, italic, tables, and more - to create engaging quiz experiences.

## 📝 How It Works

The process is straightforward:

1. Create a quiz in Markdown format
2. Run the generator
3. Get an interactive HTML quiz ready to share or embed

<div align="center">
  <div>
    <p><strong>From Markdown File:</strong></p>
    <img src="images/sample-quiz-md-file.PNG" alt="Sample Markdown Quiz File" width="85%">
  </div>
  
  <div>
    <p><strong>To Interactive Quiz:</strong></p>
    <img src="images/sample-quiz-animation.gif" alt="Sample Quiz Animation" width="85%">
    <p><em>An animated example of the generated interactive quiz</em></p>
  </div>
</div>

## 📊 Sample Quiz

Below is an example of a generated quiz. You can interact with it directly:

<div style="border: 1px solid #ddd; border-radius: 8px; padding: 20px; margin: 20px 0;">
[filename](generated-quizzes/sample-quiz.html ':include height=800px')
</div>

## ✨ Features

- **Markdown Support**: Use all standard Markdown syntax for rich text formatting
- **Multiple Question Types**: Support for multiple choice, true/false, and other question formats
- **Interactive UI**: Engaging user interface with immediate feedback
- **Customizable**: Easy to adapt to your specific needs
- **Embeddable**: Include quizzes in websites, learning management systems, or documents

## 🛠️ Getting Started

### Prerequisites

- Node.js installed on your system
- Basic knowledge of Markdown syntax

### Installation

```bash
# Clone the repository
git clone https://github.com/osandadeshan/markdown-quiz-generator.git

# Navigate to the project directory
cd markdown-quiz-generator

# Install dependencies
npm install
```

### Creating Your First Quiz

1. Create a new Markdown file with your quiz content
2. Follow the format shown in the example above
3. Run the generator:

```bash
npm run generate -- path/to/your/quiz.md
```

4. Find your generated quiz in the `generated-quizzes` folder

## 📋 Markdown Format

Your quiz Markdown file should follow this general structure:

```markdown
# Quiz Title

## Question 1
What is the capital of France?
- [ ] London
- [x] Paris
- [ ] Berlin
- [ ] Madrid

## Question 2
True or False: The Earth is flat.
- [ ] True
- [x] False
```

## 🔗 Additional Resources

- [GitHub Repository](https://github.com/osandadeshan/markdown-quiz-generator)
- [Documentation](https://github.com/osandadeshan/markdown-quiz-generator#generating-quizzes)
- [Issue Tracker](https://github.com/osandadeshan/markdown-quiz-generator/issues)

## 🤝 Contributing

Contributions are welcome! If you have ideas to improve the Markdown Quiz Generator, please:

1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/osandadeshan/markdown-quiz-generator/blob/master/LICENSE) file for details.

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')