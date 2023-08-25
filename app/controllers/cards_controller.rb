  class CardsController < ApplicationController
    def index
      @cards = Card.all
      respond_to do |format|
        format.html
        format.csv { send_data @cards.to_csv }
      end
    end
  
    def show
      @card = Card.find(params[:id])
    end
  
    def new
      @card = Card.new
    end
  
    def create
      @card = Card.create(card_params)
        if @card.valid?
          redirect_to cards_path
        end
    end
  
    def update
      @card = Card.find(params[:id])
      @card.update(card_params)
       if @card.valid?
        redirect_to card_path(@card)
       end
    end
  
    def destroy
      @card = Card.find(params[:id])
      if @card.destroy
        redirect_to cards_path
      end
    end
  
    def import
      Card.import(params[:file])
      redirect_to root_url, notice: "Vocab imported"
    end
  
  
  
    private
    def card_params
      params.require(:card).permit(:word, :definition)
    end
  end
