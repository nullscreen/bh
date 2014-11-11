module TestBh
  class App < Padrino::Application
    register Padrino::Helpers
    register Padrino::Rendering

    register Bh

    get :root, map: '/' do
      render :index
    end

    get :users, map: '/users' do
      render :index
    end
  end
end