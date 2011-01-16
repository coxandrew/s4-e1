## TODO

### Basics

X * Set up RSpec
X * Swap out Nokogiri for hpricot
X * Get list of projects with their IDs
X * Get next deadline for a given project by ID
* Add command-line options for 'help', 'status'
* Determine RED/GREEN/YELLOW status of a project based on deadline
* Memoize projects method
* Get status for a single project (based on next deadline)
* Get status for all projects
* Get list of all upcoming deadlines
  * Sort by date
  * Normalize for deadlines with the same name and date
* Add team-based calculations for Velocity
  * Hard-coded list of projects
  * Read from YAML file

## Output

Example formatting:

    total        self    children       calls  method
----------------------------------------------------------------
     0.99        0.00        0.99           1  Object#foo
     0.99        0.08        0.90           1  Fixnum#times
     0.70        0.70        0.00      100000  Bignum#to_s
     0.21        0.21        0.00      100000  Fixnum#**
     0.00        0.00        0.00         145  Class#inherited
     0.00        0.00        0.00           1  Module#method_added