namespace :get_movies do
  desc 'Populate DB'
  task :all do
    Rake::Task['genres:create'].invoke
    Rake::Task['movies:create'].invoke
  end
end