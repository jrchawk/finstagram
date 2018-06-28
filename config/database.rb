configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    set :database, {
    adapter: "sqlite3",
    database: "db/db/sqlite3"
    }
  else
    db = URI.parse(ENV['DATABASE_URL'] || 'postgres://yvfoezrpoltrdz:cd142953179499cda2ed48500bb9f16233f58c4fec9bc5ed5d3ad5b04d9e9595@ec2-54-235-196-250.compute-1.amazonaws.com:5432/dckaopl1vaam39')
    set :database, {
    adapter: "postgresql",
    host: db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: "utf8"
    }

  end


  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end
