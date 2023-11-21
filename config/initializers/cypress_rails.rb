require 'database_cleaner/active_record'
DatabaseCleaner.strategy = :truncation

return unless Rails.env.test?

CypressRails.hooks.before_server_start do

end

CypressRails.hooks.after_transaction_start do

end

CypressRails.hooks.after_state_reset do 

end

CypressRails.hooks.before_server_stop do
  
end