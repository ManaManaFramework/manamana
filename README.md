# ManaMana Framework

[![Build Status](https://travis-ci.org/ManaManaFramework/manamana.png)](https://travis-ci.org/ManaManaFramework/manamana)

[![Coverage Status](https://coveralls.io/repos/ManaManaFramework/manamana/badge.png)](https://coveralls.io/r/ManaManaFramework/manamana)


Organize your project's requirements and their associated test cases in a way that makes sense to your organization. Then keep track of the status of each as your project progresses.

## Installation

Install the gem:

    $ gem install manamana

Use the `mana` command to generate a new project:

    $ mana create my_project

This will create a directory named `my_project` containing the following items:

 * `requirements/` - Contains your project's requirements
 * `test_cases/` - Contains your project's test cases
 * `lib/stepdefs/` - Contains definitions for steps that are used by test  cases
 * `lib/helpers/` - Contains helper methods that can be used in test cases and stepdefs

## Usage

**Step 1: Write Requirements**

Writes a requirements file using the Requirements Syntax and save it under the `requirements/` directory. For example:

```
Create Tickets
==============
As a member of a software development team
I want to create tickets
So that I can track the bugs in our project

  * Newly created tickets have a status of 'Open'

  * A <Role> <Can or Cannot Create> support tickets

    Examples:
      | Role    | Can or Cannot Create |
      |---------|----------------------|
      | Manager | Can Create           |
      | Member  | Can Create           |
      | Guest   | Cannot Create        |

    Notes:
      Arbitrary text that the business analyst or domain expert
      thinks might help the development team understand the
      problem much better. Blah blah blah.
```

Notes about the syntax:

 * Text underlined by `=` characters serve as the 'group name' for the requirements that follow it
 * Text that begin with an asterisk `*` are considered requirements
 * Requirements can wrap to the next line. The end of a requirement spec is marked by two newline characters.
 * The keywords `Examples:` and `Notes:` are not really keywords. They're just optional arbitrary text that the writer can add for clarity. The compiler will ignore them.
 * Tables may or may not have borders. In the above, the border below the header row may be safely ommitted.
 * Notice that there are no word-like keywords in the above syntax making it il8n-ready at the onset.
 * The requirements file can be any text file but the convention is to use the .requirements file extension

**Step 2: Write Test Cases**

Write test cases for each requirement using the Test Case Syntax and save each as a file under the `test_cases/` directory. For example:

```
Test Case:
  A (.+) can create support tickets

  Variables:
    * Role Name   = $1
    * My Username = "norm"
    * My Password = "123qwe"

  Setup:
    * An account with username <My Username> and password <My Password> exists
    * The account with username <My Username> has a role of <Role Name>
    * I am logged out

  Teardown:
    * Delete the account with username <My Username> at exit

  Script:
    * Visit the Login page
    * Fill in the Username field with <My Username>
    * Fill in the Password field with <My Password>
    * Click the Login button
    * The New Ticket button should be enabled
```

Notes:

  * The test case name can be a string or a regexp pattern
  * The test case file can be any text file but the convention is to use the .test_case file extension
  * Organizing test cases into subfolders under the `test_cases/` directory is recommended. (e.g. `test_cases/create_tickets/`)

**Step 3: Define re-usable steps**

Writes the equivalent Ruby code for the steps used in the test cases. For example:

```
step /^Visit the (.+) page$/i do |page_name|
  # Add Ruby code here
end

step /^Fill in the (.+) field with (.+)$/i do |field_name, value|
  # Add Ruby code here
end

step /^Click the (.+) button$/i do |button_name|
  # Add Ruby code here
end
```

**Step 4: Run it!**

Run `mana start` to execute the tests and validate the requirements:

```
$ mana start
Run options: --seed 51346

## Running tests

Create Tickets
==============
As a member of a software development team
I want to create tickets
So that I can track the bugs in our project

  * Newly created tickets have a status of 'Open'             PASSED

  * A <Role> <Can or Cannot Create> support tickets

    Examples:
      | Role    | Can or Cannot Create |
      |---------|----------------------|
      | Manager | Can Create           |                      PASSED
      | Member  | Can Create           |                      PASSED
      | Guest   | Cannot Create        |                      FAILED

    Notes:
      Arbitrary text that the business analyst or domain expert
      thinks might help the development team understand the
      problem much better. Blah blah blah.


Finished tests in 0.004842s, 1445.6836 tests/s, 826.1049 assertions/s.

7 tests, 4 assertions, 0 failures, 0 errors, 0 skips
```

## Development guide
If you want to help in developing ManaMana, fork this project at [https://github.com/ManaManaFramework/manamana](https://github.com/ManaManaFramework/manamana), then clone it locally. A few requirements before proceeding:

* RVM
* Homebrew on Mac OS X
* git
* growl on Mac OS X

Once the above have been installed, go to the manamana project directory and install the required gems:

```
bundle install
```

Afterwards, install ragel. For Mac OS X, use Homebrew:

```
brew install ragel
```

Now you can start developing! Open the project folder with your favorit text editor, then, on your terminal window, run guard from the project directory:

```
guard
```