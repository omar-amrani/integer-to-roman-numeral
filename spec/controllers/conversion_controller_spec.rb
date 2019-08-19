require 'rails_helper'

describe ConversionController, type: :controller do

  let(:valid_integer_1) {113}
  let(:valid_integer_2) {3644}
  let(:out_of_range_integer) {100000}
  let(:zero) {0}
  let(:non_integer_input) {"test"}
  let(:empty_input) {""}


  describe "return_roman_numeral" do
    context 'The integer input is valid' do
      it "Should return CXIII if integer input is 113 then render new template" do
        get :return_roman_numeral, params: {integer_input: valid_integer_1}
        expect(assigns(:roman_numeral)).to eq("CXIII")
        expect(response).to render_template("new")
      end
      it "Should return MMMDCXLIV if integer input is 3644 then render new template" do
        get :return_roman_numeral, params: {integer_input: valid_integer_2}
        expect(assigns(:roman_numeral)).to eq("MMMDCXLIV")
        expect(response).to render_template("new")

      end
    end

    context 'The input is not an integer' do
      it "Should redirect to root path with a flash danger message if input is not an integer" do
        get :return_roman_numeral, params: {integer_input: non_integer_input}
        expect(flash[:danger]).to be_present
        expect(response).to redirect_to(root_path)
      end

      it "Should redirect to root path with a flash danger message if input is empty" do
        get :return_roman_numeral, params: {integer_input: empty_input}
        expect(flash[:danger]).to be_present
        expect(response).to redirect_to(root_path)
      end
    end

    context 'The integer input is out of range' do
      it "Should redirect to root path with a flash danger message if value is zero" do
        get :return_roman_numeral, params: {integer_input: zero}
        expect(flash[:danger]).to be_present
        expect(response).to redirect_to(root_path)
      end

      it "Should redirect to root path with a flash danger message if value is above 99999" do
        get :return_roman_numeral, params: {integer_input: out_of_range_integer}
        expect(flash[:danger]).to be_present
        expect(response).to redirect_to(root_path)
      end
    end
  end
end