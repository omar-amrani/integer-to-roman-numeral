Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "conversion#new"
  get "/convert", to: "conversion#return_roman_numeral"
end
