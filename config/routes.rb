Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :applications, except: [:destroy], param: :token do
        resources :chats, except: [:destroy], param: :number do
          resources :messages, except: [:destroy], param: :number
          get :search
        end
      end
    end
  end
end
