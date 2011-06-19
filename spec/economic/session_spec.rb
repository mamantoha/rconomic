require 'spec/spec_helper'

describe Economic::Session do
  subject { Economic::Session.new(123456, 'api', 'passw0rd') }

  describe "new" do
    it "should store authentication details" do
      subject.agreement_number.should == 123456
      subject.user_name.should == 'api'
      subject.password.should == 'passw0rd'
    end
  end

  describe "client" do
    subject { Economic::Session.new(123456, 'api', 'passw0rd') }

    it "returns a Savon::Client" do
      subject.client.should be_instance_of(::Savon::Client)
    end
  end

  describe "connect" do
    it "connects to e-conomic with authentication details" do
      savon.expects('Connect').with(has_entries(:agreementNumber => 123456, :userName => 'api', :password => 'passw0rd')).returns(:success)
      subject.connect
    end

    it "stores the cookie for later connections" do
      savon.expects('Connect').returns({:headers => {'Set-Cookie' => 'cookie'}})
      subject.connect
      subject.client.http.headers['Cookie'].should == 'cookie'
    end
  end

  describe "debtors" do
    it "returns a DebtorProxy" do
      subject.debtors.should be_instance_of(Economic::DebtorProxy)
    end

    it "memoizes the proxy" do
      subject.debtors.should === subject.debtors
    end
  end

  describe "request" do
  end

end