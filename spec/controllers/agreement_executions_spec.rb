require 'spec_helper'

describe AgreementExecutionsController do
  describe "GET #index" do
    it "populates :agreement_executions" do

    end
    it "renders #index" do

    end
  end

  describe "GET #show" do
    it "renders #show if :id is valid"
    it "populates :agreement_execution from valid :id"
    it "redirects to #index if agreement_execution not found"
    it "flases :error if agreement_execution not found"
  end

  describe "GET #new" do
    it "renders #new"
    it "creates empty :agreement_execution object"
  end

  describe "POST #create" do
    it "redirects to #index if :agreement_execution saved"
    it "flashes :success if :agreement_execution saved"
    it "creates new :agreement_execution"
    it "renders #new if :agreement_execution not saved"
    it "flashes :error if :agreement_execution not saved"
  end

  describe "GET #edit" do
    it "renders #edit if :id is correct"
    it "finds associated :agreement_execution if correct :id"
    it "redirects to #index if :id not found"
    it "flashes :error if :id not found"
  end

  describe "PUT #update" do
    it "redirects to #index if :agreement_execution updated"
    it "updates :agreement_execution if given proper params"
    it "flash :success is not nil if :agreement_execution updated"
    it "redirects to #edit if :agreement_execution not updated"
    it "flash :error is not nil if :agreement_execution not updated"
  end

  describe "DELETE #destroy" do
    it "redirects to #index if successfully deleted"
    it "flash :success is not nil if :agreement_execution deleted"
    it "successfully deleted :agreement_execution"
    it "redirects to referrer if :agreement_execution deletion failed"
    it "flash :error is not nil if :agreement_execution not deleted"
  end
end
