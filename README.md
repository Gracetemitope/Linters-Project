# Linters-Project

![](https://img.shields.io/badge/Microverse-blueviolet)

# Project Description
This a Ruby Linter Project. It flag the following errors in any ruby code:
- Check Trailing white errors
- Check empty line spaces
- Check end of block
- Check indentation

# Project Files
- The 'bin' folder: This consist of the main.rb file.
The main is the executable file that controls lint logic.

- The 'lib' folder: This consists of two files which include:
file_reading.rb: It consist of the class for reading through a file
linters.rb: This class checks for mistakes within the code. Different methods are used to do this checks.

- rspec Folder: This consist of the linters_spec.rb. It is primarily for writing unit tests to ensure all the methods pass

- test.rb This short program is used to test our small linting program and see how it responds when a file is passed for error checks.

## Built With

- Ruby

## How to Get One Running

- Step 1: clone on your local machine
- Step 2: Specify the path to the file you want to check by changing the value of file_path in main.rb. Note:  The ruby file will run only if the path given is correct
- Step 3: You have done step and step? Great! All you have to do now is to run this command bin/main.rb

## How to Run the Tests
- The Rspec unit tests reside in linters_spec.rb file in the spec folder.
- To run the test cases, type rspec spec/linters_spec.rb in your terminal.
- You want to play around with the test cases? Be my guest in the spec/linters_spec.rb file

👤 **Author**

- GitHub: [@githubhandle](https://github.com/Gracetemitope)
- Twitter: [@twitterhandle](https://twitter.com/DevGrachy)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/ajanaku-temitope-427778199/)


## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Micronauts

## 📝 License

This project is [MIT](lic.url) licensed.
