# README



## Running TRR-Indika

This Rails app was developed using Ruby 2.3.3 and Rails 5.


1. Unpack tarball.

   tar xvfz trr-indika.tar.gz
   cd trr-indika

2. Create gemset.

   rvm gemset create ruby-2.3.3@realreal
   rvm use ruby-2.3.3@realreal
   
3. Install gems.

   bundle install

4. You may need to run Sequalite migrations.

    rake db:create
    rake db:migrate
    
    RAILS_ENV=test rake db:create
    RAILS_ENV=test rake db:migrate
    
    RAILS_ENV=production rake db:create
    RAILS_ENV=production rake db:migrate

5. Run the Rails server.

   bin/rails server
   
6. Browse.

   open 'http://127.0.0.1:3000'
