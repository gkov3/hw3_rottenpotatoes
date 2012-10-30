#` Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    m = Movie.create!(movie)
    m.save!()
  
  
  end
# flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.a
#  
   r = Regexp.new(".*#{e1}.*#{e2}.*",Regexp::MULTILINE)
assert page.body.match(r) 
#flunk "Unimplemented"
end

When /I press (.*)/ do | button|
  click_button(button)
end




# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/[\s]*,[\s]*/).each  do |rating|

  if uncheck 
      uncheck("ratings_#{rating}")
    else
      check("ratings_#{rating}")
    end

  end
end

Then /I should( not)? see the following movies: (.*)/ do |not_see, movies|

  movies.split(/[\s]*,[\s]*/).each do |movie|  
    
    if page.respond_to? :should
       if not_see
         page.should have_no_content(movie)
       else
          page.should have_content(movie)
       end
    else
        if not_see 
          assert page.has_no_content?(movie) 
       else
          assert page.has_content?(movie)
       end
    end
  end
end

Then /I should see (all|none) of the movies/ do |param|

    if( param == 'all')
     count = 10
    else
     count =0
    end
    assert page.all('table#movies tbody tr').count == count
end

