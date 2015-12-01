require File.dirname(__FILE__) + '/spec_helper'

describe 'KpctoonApp' do

  before do
  end

  describe "データあり" do
    before do
      get url
    end

    subject {last_response}

    describe "/" do
      let(:url){'/'}
      it "表示可能" do
        expect(subject).to be_ok
      end
    end

    describe "/" do
      let(:url){'/?url=http%3A%2F%2Fwww.susanooshinwa.jp%2F'}
      it "表示可能" do
        expect(subject).to be_ok
      end
    end

  end

end

