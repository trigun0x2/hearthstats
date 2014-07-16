require 'spec_helper'

describe ChargesController do
  let(:user) { create :user }

  before do
    sign_in user
  end

end
