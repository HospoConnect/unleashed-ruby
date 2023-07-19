RSpec.describe Unleashed do
  it "has a version number" do
    expect(Unleashed::Version).not_to be nil
  end

  it 'initialises client' do
    expect{Unleashed::Client.new}.not_to raise_error
  end
end
