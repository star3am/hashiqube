# Git

<div align="center">
  <img src="images/git-logo.png" alt="Git Logo" width="300px">
  <br><br>
  <p><strong>The modern standard for version control</strong></p>
</div>

## 🚀 About

In this HashiQube DevOps lab, you'll get hands-on experience with Git, the world's most popular version control system.

Git is a free and open-source distributed version control system designed to handle everything from small to very large projects with speed and efficiency. It's easy to learn, has a small footprint, and offers lightning-fast performance.

Git outperforms traditional SCM tools like Subversion, CVS, Perforce, and ClearCase with powerful features such as:

- Efficient local branching
- Convenient staging areas
- Flexible workflows
- Distributed development model

## 💻 GitHub Desktop Client

To make working with Git even easier, you can use GitHub Desktop, a user-friendly Git client that simplifies your development workflow.

<div align="center">
  <a href="https://desktop.github.com/" target="_blank">
    <img src="images/github-desktop-screenshot.png" alt="GitHub Desktop Screenshot" width="85%">
  </a>
  <p><em>GitHub Desktop provides a user-friendly interface for Git operations</em></p>
</div>

[Download GitHub Desktop](https://desktop.github.com/)

GitHub Desktop helps you:

- Focus on your work instead of fighting with Git syntax
- Visualize changes with an intuitive interface
- Easily switch between branches
- Simplify common Git tasks with a few clicks
- Perfect for both beginners and experienced users

## 📑 Git Cheat Sheet

To help you quickly learn the most common Git commands, here's a handy cheat sheet you can use as a wallpaper:

<div align="center">
  <img src="images/git-cheatsheet-wallpaper.png" alt="Git Cheat Sheet Wallpaper" width="85%">
  <p><em>Git Cheat Sheet - A helpful reference for common Git commands</em></p>
</div>

## 🛠️ Essential Git Commands

### Getting Started

```bash
# Initialize a new Git repository
git init

# Clone an existing repository
git clone https://github.com/username/repository.git
```

### Making Changes

```bash
# Check status of your working directory
git status

# Add files to staging area
git add filename.txt      # Add specific file
git add .                 # Add all files

# Commit changes
git commit -m "Descriptive message"

# Commit all tracked changes without a separate add step
git commit -am "Descriptive message"
```

### Working with Branches

```bash
# List all branches
git branch

# Create a new branch
git branch branch-name

# Switch to a branch
git checkout branch-name

# Create and switch to a new branch in one command
git checkout -b branch-name

# Merge a branch into your current branch
git merge branch-name
```

### Remote Repositories

```bash
# Add a remote repository
git remote add origin https://github.com/username/repository.git

# Push changes to remote
git push origin branch-name

# Pull changes from remote
git pull origin branch-name

# Fetch changes without merging
git fetch origin
```

## 🔄 Common Git Workflows

### Feature Branch Workflow

1. Create a branch for a new feature: `git checkout -b new-feature`
2. Make changes and commit: `git commit -am "Add new feature"`
3. Push to remote: `git push origin new-feature`
4. Create a pull request for review
5. Merge into main branch after approval

### Gitflow Workflow

- `main` branch contains production code
- `develop` branch for ongoing development
- Feature branches for new features
- Release branches for release preparation
- Hotfix branches for urgent production fixes

## 🔗 Additional Resources

- [Git Official Website](https://git-scm.com/)
- [Pro Git Book](https://git-scm.com/book/en/v2) - Comprehensive free online book
- [GitHub Learning Lab](https://lab.github.com/) - Interactive tutorials
- [Git Cheat Sheet by GitHub](https://education.github.com/git-cheat-sheet-education.pdf)
- [Learn Git Branching](https://learngitbranching.js.org/) - Interactive visualization tool
- [Oh Shit, Git!?!](https://ohshitgit.com/) - Helping you fix Git mistakes

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')
