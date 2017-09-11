# Forest Mitigation Simulator
This is a project I worked on for Natural Resources Canada as part of my 8 month coop from January 2017 to September 2017. 
It is publicly hosted with their permission to be used as an example of my abilites. It was version controlled on git before, but I did not 
bring the repository information with me as transfer speeds to USB were limiting, which is why I created a brand new repository.

### What it does
Given a base forest carbon modelling scenario, and an alternate forest carbon modelling scenario, it is possible to estimate the climate change
impacts of the alternate scenario relative to the base scenario. This program is a graphical user interface aimed at providing a means for 
collaborators with the carbon accounting team at NRCan to create their own forest carbon modelling scenarios and then view the possible mitigation
impacts of their scenario. This program is not functional as it is in this repository as it was built on a framework that exists only on the NRCan network.
That is also why there are no example configs. 

### Context behind the program
Before writing this program my experience with R was almost none, and my experience with R Shiny was even less. This program was a good introduction
to writing large scale programs, as well as a good introduction to reactive programming. Originally the project started as two files,
ui.R and server.R, but the files eventually grew to extremely large sizes and became difficult to parse so I refactored the project to look
more like my Growth Curve Coercer project. There was extensive documentation written for this program but it was part of a larger documentation
project for NRCan and I could not bring it with me. Overall, I worked on this project on and off for 5 months, probably spending 2 months of my
8 month term dedicated to this project.
