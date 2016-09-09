describe "Categories management" do

  it "Created a new category" do
    visit root_path
    click_link "Add new category"
    fill_in "Name", with: "Main category name"
    click_button "Create Category"
    expect(page).to have_text("Main category name")
  end

  it "Updates category" do
    create :category, name: 'Main category'
    visit root_path
    click_link "Edit"
    fill_in "Name", with: "Updated category name"
    click_button "Update Category"
    expect(page).to have_text("Updated category name")
  end

  it "redirects to new category page" do
    visit root_path
    click_link  "Add new category"
    expect(page).to have_text("New category")
    expect(page).to have_text("Name")
  end

  it "redirects to edit category page" do
    create :category
    visit root_path
    click_link  "Edit"
    expect(page).to have_text("Edit category")
    expect(page).to have_text("Name")
  end

end