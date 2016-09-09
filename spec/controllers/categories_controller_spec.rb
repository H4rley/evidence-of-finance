require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "assigns @categories" do
      category = create :category
      get :index
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end

    it "assigns @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "GET #edit" do

    before(:each) do
      @category = create :category
      get :edit, id: @category.id
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end

    it "assigns @category" do
      expect(assigns(:category)).to eq(@category)
    end
  end

  describe "POST #create" do
    it "redirects to root path" do
      post :create, category: {name: 'Main'}
      expect(response).to redirect_to(categories_path)
    end

    it "redirects to root path" do
      expect{post :create, category: {name: 'Main'}}.to change(Category, :count).by(1)
    end
  end

  describe "PATCH #update" do
    before(:each) do
      @category = create :category, name: "Main"
    end

    it "redirects to index" do
      patch :update, id: @category.id, category: {name: "Changed name"}
      expect(response).to redirect_to categories_path
    end

    it "updates name" do
      patch :update, id: @category.id, category: {name: "Changed name"}
      @category.reload
      expect(@category.name).to eq("Changed name")
    end
  end

end