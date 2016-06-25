require 'rails_helper'
require 'spec_helper'
require 'geocoder'
require "#{Rails.root}/lib/location"

describe SmartCities::Location do
  
  let(:sao_jose){ [-23, -46] }
  let(:sao_paulo){ [-23.559616, -46.731386] }
  let(:arapiraca){ [-9.740810, -36.641173] }
  let(:butantan){ [-23.571659, -46.708118] }
  describe ".extract_postal_code" do

    context "when results have no postal code" do
      let(:results){ Geocoder.search(sao_jose) }
      subject { SmartCities::Location.extract_postal_code(results)}
      it { is_expected.to eq nil }
    end

    context "when results have incomplete postal code" do
      let(:results){ Geocoder.search(arapiraca) }
      subject { SmartCities::Location.extract_postal_code(results)}
      it { is_expected.to eq(results.first.postal_code << "-000") }
    end

    context "when the first result has incomplete postal code" do
      let(:results){ Geocoder.search(sao_paulo) }
      subject { SmartCities::Location.extract_postal_code(results)}
      it { is_expected.to eq "05508-090" }
    end

    context "when the first result has complete postal code" do
      let(:results){ Geocoder.search(butantan) }
      subject { SmartCities::Location.extract_postal_code(results)}
      it { is_expected.to eq "05503-001" }
    end
  end
end
