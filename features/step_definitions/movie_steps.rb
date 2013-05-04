# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(/[",\s]+/).select{ |x| x.length > 0 }.each do |rating|
    if uncheck == 'un'
      uncheck("ratings_#{rating}")
    else
      check("ratings_#{rating}")
    end
  end
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  eRegexp = Regexp.new( "#{e1}.*#{e2}", Regexp::IGNORECASE | Regexp::MULTILINE )
  page.text.should match( eRegexp )
end


Then /the director of "(.*)" should be "(.*)"/ do |title, director|
  #director_regexp = Regexp.new( "#{e1}.*#{e2}", Regexp::IGNORECASE | Regexp::MULTILINE )
  page.text.should match( /Director:\s*#{director}/i)
end

# I should see no, all or a count of movies
Then /I should see (no|all(( of)? the)?|\d+) movies/ do |how_many, ignore1, ignore2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  if how_many =~ /^no/
    expectedCount = 0
  elsif how_many =~ /^all/
    expectedCount = Movie.count
  else
    expectedCount = Integer(how_many)
  end
  rowCount = page.all('table#movies tbody tr').count 
  rowCount.should == expectedCount
end


