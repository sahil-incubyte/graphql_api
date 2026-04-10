RSpec.describe "Users Query", type: :request do
  let!(:user) { create(:user, name: "Sahil") }

  let(:query) do
    <<~GQL
      query {
        users {
          id
          name
        }
      }
    GQL
  end

  it "returns users" do
    result = GraphqlApiSchema.execute(query)

    data = result["data"]["users"]

    expect(data.length).to eq(1)
    expect(data[0]["name"]).to eq("Sahil")
  end
end
