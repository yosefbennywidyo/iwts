require "rails_helper"

RSpec.describe TransactionHistoriesController, type: :routing do
  describe "routing" do
    context "as a user" do
      it "routes user transaction histories to transaction histories controller" do
        expect(get(user_transaction_histories_path(user_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "index",
          user_code: "1"
        )
      end
      
      it "routes user debit to transaction histories controller" do
        expect(get(debit_user_transaction_histories_path(user_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "debit",
          user_code: "1"
        )
      end

      it "routes user credit to transaction histories controller" do
        expect(get(credit_user_transaction_histories_path(user_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "credit",
          user_code: "1"
        )
      end

      it "routes user new_debit to transaction histories controller" do
        expect(post(new_debit_user_transaction_histories_path(user_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "new_debit",
          user_code: "1"
        )
      end

      it "routes user new_credit to transaction histories controller" do
        expect(post(new_credit_user_transaction_histories_path(user_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "new_credit",
          user_code: "1"
        )
      end
    end

    context "as a team" do
      it "routes team transaction histories to transaction histories controller" do
        expect(get(team_transaction_histories_path(team_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "index",
          team_code: "1"
        )
      end
      
      it "routes team debit to transaction histories controller" do
        expect(get(debit_team_transaction_histories_path(team_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "debit",
          team_code: "1"
        )
      end

      it "routes team credit to transaction histories controller" do
        expect(get(credit_team_transaction_histories_path(team_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "credit",
          team_code: "1"
        )
      end

      it "routes team new_debit to transaction histories controller" do
        expect(post(new_debit_team_transaction_histories_path(team_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "new_debit",
          team_code: "1"
        )
      end

      it "routes team new_credit to transaction histories controller" do
        expect(post(new_credit_team_transaction_histories_path(team_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "new_credit",
          team_code: "1"
        )
      end
    end

    context "as a stock" do
      it "routes stock transaction histories to transaction histories controller" do
        expect(get(stock_transaction_histories_path(stock_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "index",
          stock_code: "1"
        )
      end
      
      it "routes stock debit to transaction histories controller" do
        expect(get(debit_stock_transaction_histories_path(stock_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "debit",
          stock_code: "1"
        )
      end

      it "routes stock credit to transaction histories controller" do
        expect(get(credit_stock_transaction_histories_path(stock_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "credit",
          stock_code: "1"
        )
      end

      it "routes stock new_debit to transaction histories controller" do
        expect(post(new_debit_stock_transaction_histories_path(stock_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "new_debit",
          stock_code: "1"
        )
      end

      it "routes stock new_credit to transaction histories controller" do
        expect(post(new_credit_stock_transaction_histories_path(stock_code: 1))).to route_to(
          controller: "transaction_histories",
          action: "new_credit",
          stock_code: "1"
        )
      end
    end
  end
end
