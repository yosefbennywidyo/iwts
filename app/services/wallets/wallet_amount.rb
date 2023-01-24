module Wallets
  class WalletAmount < ApplicationService
    def initialize(params={})
      @title = title
      @description = description
      @author_id = author_id
      @genre_id = genre_id
    end

    def call
      create_book
    end

    private

    def create_book
      # ...
    end
  end
end