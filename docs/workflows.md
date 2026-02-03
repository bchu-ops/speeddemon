# CI/CD Workflow Documentation

## test.yml
Runs automated tests on every push and pull request.  
This workflow checks out the repository, sets up Python, installs project and development dependencies, and executes the test suite to ensure code changes do not break existing functionality.

---

## deploy.yml
Runs deployment steps when changes are pushed to the main branch.  
This workflow checks out the repository and executes deployment logic (currently a placeholder), and is intended to automate releasing the application to production or a hosting environment.
