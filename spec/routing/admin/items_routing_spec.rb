require "rails_helper"

RSpec.describe Admin::ItemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/items").to route_to("admin/items#index")
    end

    it "routes to #show" do
      expect(get: "/admin/items/1").to route_to("admin/items#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/items").to route_to("admin/items#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/items/1").to route_to("admin/items#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/items/1").to route_to("admin/items#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/items/1").to route_to("admin/items#destroy", id: "1")
    end
  end
end
