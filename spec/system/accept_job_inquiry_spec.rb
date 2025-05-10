RSpec.describe "accept a job inquiry:" do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user: user) }
  let(:job) { FactoryBot.create(:job, project: project) }
  let(:applicant) { FactoryBot.create(:user) }
  let(:inquiry) { FactoryBot.create(:inquiry, job: job, user: applicant) }

  before do
    user.confirm
    applicant.confirm
  end

  after(:each) do
    # Ensure proper cleanup
    Capybara.current_session.driver.quit if Capybara.current_session.driver.respond_to?(:quit)
  end

  it "logs in, get to the project page and add member" do
    visit(dashboard_path)

    fill_in("user_email", with: user.email)
    fill_in("user_password", with: user.password)
    click_on("Log in")
    
    find_by_id("test-id-inquiries-menu").hover
    click_on("test-id-on-hold-inquiries-menu")
    click_on("test-id-on-hold-inquiry")
    click_on("Accept")

    expect(page).to have_selector('span', text: 'accepted')
    expect(page).to have_selector('div', text: 'Status updated to accepted')
  end
end
