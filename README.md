# Adopt Don't Shop Paired Project
BE Mod 2 Week 2/3 Pair Project

## Background and Description

"Adopt Don't Shop Paired" is a fictitious pet adoption platform where visitors can favorite pets and apply to adopt their newest furry friend.

Students will be put into pairs to complete the project.

## Learning Goals

### Rails
* Describe use cases for a model that inherits from ApplicationRecord vs. a PORO
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Make use of flash messages
* Use Inheritance from ApplicationController or a student created controller to store methods that will be used in multiple controllers
* Use POROs to logically organize code for objects not stored in the database

### ActiveRecord
* Use built-in ActiveRecord methods to:
* create queries that calculate, select, filter, and order data from a single table

### Databases
* Describe Database Relationships, including the following terms:
* Many to Many
* Join Table

### Testing and Debugging
* Write feature tests utilizing
* Sad Path Testing
* Write model tests with RSpec including validations, and class and instance methods

### Web Applications
* Explain how Cookies/Sessions are used to create and maintain application state
* Describe and implement ReSTful routing
* Identify use cases for, and implement non-ReSTful routes
* Identify the different components of URLs(protocol, domain, path, query params)
## Requirements

- must use Rails 5.1.x
- must use PostgreSQL
- all controller and model code must be tested via feature tests and model tests, respectively
- must use good GitHub branching, team code reviews via GitHub comments, and use of a project planning tool
- must include a README to describe their project

## Permitted

- use FactoryBot to speed up your test development
- use "rails generators" to speed up your app development

## Not Permitted

- do not use JavaScript for pagination or sorting controls

## Permission

- if there is a specific gem you'd like to use in the project, please get permission from your instructors first

## Setup
This project builds off of the solo project, Adopt Don't Shop. Between you and your partner, choose which one of your repos you'd like to use. If you choose to use Partner A's solo project, Partner A will clone their project into a new directory and push up to a new repo on github. Then, Partner A should add Partner B as a collaborator to that project.

## User Stories

```
[x] done

User Story 1, Deploy your application to Heroku

As a visitor or user of the site
I will perform all user stories
By visiting the application on Heroku.
Localhost is fine for development, but
the application must be hosted on Heroku.
```


## Shelter Reviews
Users will be able to share their experiences with a shelter through providing reviews. Users should be able to create a review with a title (Example: "Awesome place!"), a rating (out of 5), and content (Example: "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!"). A user can also upload one picture (image url address) for their review as well, but this is optional.

```
[x] done

User Story 2, Shelter Reviews

As a visitor,
When I visit a shelter's show page,
I see a list of reviews for that shelter
Each review will have:
- title
- rating
- content
- an optional picture
```

```
[x] done

User Story 3, Shelter Review Creation

As a visitor,
When I visit a shelter's show page
I see a link to add a new review for this shelter.
When I click on this link, I am taken to a new review path
On this new page, I see a form where I must enter:
- title
- rating
- content
I also see a field where I can enter an optional image (web address)
When the form is submitted, I should return to that shelter's show page
and I can see my new review
```

```
[x] done

User Story 4, Shelter Review Creation, cont.

As a visitor,
When I fail to enter a title, a rating, and/or content in the new shelter review form, but still try to submit the form
I see a flash message indicating that I need to fill in a title, rating, and content in order to submit a shelter review
And I'm returned to the new form to create a new review
```

```
[ ] done

User Story 5, Edit a Shelter Review

As a visitor,
When I visit a shelter's show page
I see a link to edit the shelter review next to each review.
When I click on this link, I am taken to an edit shelter review path
On this new page, I see a form that includes that review's pre populated data:
- title
- rating
- content
- image
I can update any of these fields and submit the form.
When the form is submitted, I should return to that shelter's show page
And I can see my updated review
```

```
[ ] done

User Story 6, Edit a Shelter Review, cont.

As a visitor,
When I fail to enter a title, a rating, and/or content in the edit shelter review form, but still try to submit the form
I see a flash message indicating that I need to fill in a title, rating, and content in order to edit a shelter review
And I'm returned to the edit form to edit that review
```

```
[ ] done

User Story 7, Delete a Shelter Review

As a visitor,
When I visit a shelter's show page,
I see a link next to each shelter review to delete the review.
When I delete a shelter review I am returned to the shelter's show page
And I should no longer see that shelter review
```


## Favorite a Pet
Users will be able to favorite a pet and keep track of pet's they're interested in

```
[ ] done

User Story 8, Favorite Indicator

As a visitor
I see a favorite indicator in my navigation bar
The favorite indicator shows a count of pets in my favorites list
I can see this favorite indicator from any page in the application
```

```
[ ] done

User Story 9, Favorite Creation

As a visitor
When I visit a pet's show page
I see a button or link to favorite that pet
When I click the button or link
I'm taken back to that pet's show page
I see a flash message indicating that the pet has been added to my favorites list
The favorite indicator in the nav bar has incremented by one
```


```
[ ] done

User Story 10, Favorite Index Page

As a visitor
When I have added pets to my favorites list
And I visit my favorites index page ("/favorites")
I see all pets I've favorited
Each pet in my favorites shows the following information:
- pet's name (link to pets show page)
- pet's image
```

```
[ ] done

User Story 11, Favorite Indicator links to Index Page

As a visitor
When I click on the favorite indicator in the nav bar
I am taken to the favorites index page
```

```
[ ] done

User Story 12, Can't Favorite a Pet More Than Once

As a visitor
After I've favorited a pet
When I visit that pet's show page
I no longer see a link to favorite that pet
But I see a link to remove that pet from my favorites
When I click that link
A delete request is sent to "/favorites/:pet_id"
And I'm redirected back to that pets show page where I can see a flash message indicating that the pet was removed from my favorites
And I can now see a link to favorite that pet
And I also see that my favorites indicator has decremented by 1
```

```
[ ] done

User Story 13, Remove a Favorite from Favorites Page

As a visitor
When I have added pets to my favorites list
And I visit my favorites page ("/favorites")
Next to each pet, I see a button or link to remove that pet from my favorites
When I click on that button or link to remove a favorite
A delete request is sent to "/favorites/:pet_id"
And I'm redirected back to the favorites page where I no longer see that pet listed
And I also see that the favorites indicator has decremented by 1
```

```
[ ] done

User Story 14, No Favorites Page

As a visitor
When I have not added any pets to my favorites list
And I visit my favorites page ("/favorites")
I see text saying that I have no favorited pets
```

```
[ ] done

User Story 15, Remove all Favorite from Favorites Page

As a visitor
When I have added pets to my favorites list
And I visit my favorites page ("/favorites")
I see a link to remove all favorited pets
When I click that link
I'm redirected back to the favorites page
I see the text saying that I have no favorited pets
And the favorites indicator returns to 0
```


## Apply for Pet(s)
Users will be able to submit an application for one ore more pets they they've favorited.

```
[ ] done

User Story 16, Applying for a Pet

As a visitor
When I have added pets to my favorites list
And I visit my favorites page ("/favorites")
I see a link for adopting my favorited pets
When I click that link I'm taken to a new application form
At the top of the form, I can select from the pets of which I've favorited for which I'd like this application to apply towards (can be more than one)
When I select one or more pets, and fill in my
- Name
- Address
- City
- State
- Zip
- Phone Number
- Description of why I'd make a good home for this/these pet(s)
And I click on a button to submit my application
I see a flash message indicating my application went through for the pets that were selected
And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites
```

```
[ ] done

User Story 17, Incomplete application for a Pet

As a visitor
When I apply for a pet and fail to fill out any of the following:
- Name
- Address
- City
- State
- Zip
- Phone Number
- Description of why I'd make a good home for this/these pet(s)
And I click on a button to submit my application
I'm redirect back to the new application form to complete the necessary fields
And I see a flash message indicating that I must complete the form in order to submit the application
```

```
[ ] done

User Story 18, List of Pets that have applications on them

As a visitor
After one or more applications have been created
When I visit the favorites index page
I see a section on the page that has a list of all of the pets that have at least one application on them
Each pet's name is a link to their show page
```

```
[ ] done

User Story 19, Application Show Page

As a visitor
When I visit an applications show page "/applications/:id"
I can see the following:
- name
- address
- city
- state
- zip
- phone number
- Description of why the applicant says they'd be a good home for this pet(s)
- names of all pet's that this application is for (all names of pets should be links to their show page)
```


```
[ ] done

User Story 20, Pet Applications Index Page

As a visitor
When I visit a pets show page
I see a link to view all applications for this pet
When I click that link
I can see a list of all the names of applicants for this pet
Each applicant's name is a link to their application show page
```

```
[ ] done

User Story 21, Pet Applications Index Page When No Applications

As a visitor
When I visit a pet applications index page for a pet that has no applications on them
I see a message saying that there are no applications for this pet yet
```

```
[ ] done

User Story 22, Approving an Application

As a visitor
When I visit an application's show page
For every pet that the application is for, I see a link to approve the application for that specific pet
When I click on a link to approve the application for one particular pet
I'm taken back to that pet's show page
And I see that the pets status has changed to 'pending'
And I see text on the page that says who this pet is on hold for (Ex: "On hold for John Smith", given John Smith is the name on the application that was just accepted)
```

```
[ ] done

User Story 23, Users can get approved to adopt more than one pet

As a visitor
When an application is made for more than one pet
When I visit that applications show page
I'm able to approve the application for any number of pets
```

```
User Story 24, Pets can only have one approved application on them at any time

[ ] done

As a visitor
When a pet has more than one application made for them
And one application has already been approved for them
I can not approve any other applications for that pet but all other applications still remain on file (they can be seen on the pets application index page)
(This can be done by either taking away the option to approve the application, or having a flash message pop up saying that no more applications can be approved for this pet at this time)
```

```
User Story 25, Approved Applications can be revoked

[ ] done

As a visitor
After an application has been approved for a pet
When I visit that applications show page
I no longer see a link to approve the application for that pet
But I see a link to unapprove the application for that pet
When I click on the link to unapprove the application
I'm taken back to that applications show page
And I can see the button to approve the application for that pet again
When I go to that pets show page
I can see that the pets adoption status is now back to adoptable
And that pet is not on hold anymore
```
---

## Shelters
Visitors will have additional constraints when manipulating shelter data in the database.



```
[ ] done

User Story 26, Shelters with Pets that have pending status cannot be Deleted

As a visitor
If a shelter has approved applications for any of their pets
I can not delete that shelter
Either:
- there is no button visible for me to delete the shelter
- if I click on the delete link for deleting a shelter, I see a flash message indicating that the shelter can not be deleted.
```

```
[ ] done

User Story 27, Shelters can be Deleted as long as all pets do not have approved applications on them

As a visitor
If a shelter doesn't have any pets with a pending status
I can delete that shelter
When that shelter is deleted
Then all of their pets are deleted as well
```

```
[ ] done

User Story 28, Deleting Shelters Deletes its Reviews

As a visitor
When I delete a shelter
All reviews associated with that shelter are also deleted
```

```
[ ] done

User Story 29, Flash Messages for Shelter Create and Update

As a visitor
When I am updating or creating a new shelter
If I try to submit the form with incomplete information
I see a flash message indicating which field(s) I am missing
```

```
[ ] done

User Story 30, Shelter Statistics

As a visitor
When I visit a shelter's show page
I see statistics for that shelter, including:
- count of pets that are at that shelter
- average shelter review rating
- number of applications on file for that shelter
```

---

## Pet
Visitors will have additional constraints when manipulating pet data in the database.



```
[ ] done

User Story 31, Pets with approved applications cannot be deleted

As a visitor
If a pet has an approved application on them
I can not delete that pet
Either:
- there is no button visible for me to delete the pet
- if I click on the delete button, I see a flash message indicating that the pet can not be deleted.
```

```
[ ] done

User Story 32, Deleting a pet removes it from favorites

As a visitor
If I've added a pet to my favorites
When I try to delete that pet from the database
They are also removed from the favorites list
```

```
[ ] done

User Story 33, Flash Message for Pet Create and Update

As a visitor
When I am updating or creating a pet
If I try to submit the form with incomplete information
I see a flash message indicating which field(s) I am missing
```
---

## Usability
Visitors will have additional constraints when manipulating pet data in the database.

```
[ ] done

User Story 34, All Pet Names are links to that Pet's Show Page

As a visitor
Any time I see a pet's name within this application
It is a link to their show page
```

```
[ ] done

User Story 35, All Shelter Names are links to that Shelter's Show Page

As a visitor
Any time I see a shelter's name within this application
It is a link to their show page
```

```
[ ] done

User Story 36, All Applicant Names are links to that Applicant's application

As a visitor
Any time I see an applicant's name within this application
It is a link to their application show page
```

---

## Extensions

```
User Story 37, List of Pets with Approved Applications

[ ] done

As a visitor
After an application has been approved for one or more pets
When I visit the favorites page
I see a section on the page that has a list of all of the pets that have an approved application on them
Each pet's name is a link to their show page
```

```
[ ] done

User Story 38, Reviews have a default picture

As a visitor
When I create a review for a shelter
And do not fill in the field for an image
A default image is used and displayed for that review upon submission
```

```
[ ] done

User Story 39, Sortable Reviews

As a visitor,
When I visit a shelter's show page to see their reviews,
I see additional links to sort their reviews in the following ways:
- sort reviews by highest rating, then by descending date
- sort reviews by lowest rating, then by ascending date
```

```
[ ] done

User Story 40, More Shelter Statistics

As a visitor,
When I visit the shelter's index page
I see the top 3 highest rated shelters highlighted on a specific part of the page
```




## Rubric
Note: In order to get 4's criteria under 4's must be completed.

| | **Feature Completeness** | **Rails** | **ActiveRecord** | **Testing and Debugging** |
| --- | --- | --- | --- | --- |
| **4: Exceptional**  | All User Stories 100% complete including all sad paths and edge cases, and some extension work completed | Students implement strategies not discussed in class to effectively organize code using POROs and adhere to MVC | Highly effective and efficient use of ActiveRecord beyond what we've taught in class. Even `.each` calls will not cause additional database lookups. | Very clear Test Driven Development. Test files are extremely well organized and nested. Students utilize `before :each` blocks. 100% coverage for features and models |
| **3: Passing** | Students complete all User Stories. No more than 2 Stories fail to correctly implement sad path and edge case functionality. | Students use the principles of MVC and POROs vs. Models to effectively organize code. Students can defend any of their design decisions. Action View helpers are used. Routes and Actions are following RESTful conventions. | ActiveRecord is used in a clear and effective way to read/write data using no Ruby to process data. Project fully leverages AR associations and methods | 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. Scored a 3 or higher in Feature Completeness |
| **2: Passing with Concerns** | Students complete all but 1 - 3 User Stories | Students utilize MVC and POROs to organize code, but cannot defend some of their design decisions. Some routes and actions are not restful. | Ruby is used to process data that could use ActiveRecord instead. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective. |
| **1: Failing** | Students fail to complete 4 or more User Stories | Students do not effectively organize code using MVC and/or POROs | Ruby is used to process data more often than ActiveRecord | Below 90% coverage for either features or models. |
