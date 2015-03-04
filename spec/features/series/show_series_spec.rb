require 'spec_helper'

describe "Viewing an individual series" do 

	before do 
		@series = Series.create!(series_attributes)

		user = User.create!(user_attributes)
		sign_in(user)
	end

	it "shows the series title" do 
		visit series_path(@series)

		expect(page).to have_text(@series.name)
	end

	context "when a series has comics" do

		it "lists the series' comics details" do 
			comic = @series.comics.create!(comic_attributes)

			visit series_path(@series)

			expect(page).to have_text(comic.number)
			expect(page).to have_text(comic.title)
			expect(page).to have_text(comic.redemption_code)
		end

		it "does not show the redemption code when a redemption code has been redeemed" do 
			comic = @series.comics.create!(comic_attributes)

			comic.redeemed = true

			comic.save

			visit series_path(@series)

			expect(page).not_to have_text(comic.redemption_code)
			expect(page).not_to have_text(comic.title)
			#This isn't working because I cannot seem to change the default form false to true
		end
		
		it "shows the redemption code when a redemption code has not been redeemed" do 
			comic = @series.comics.create!(comic_attributes)

			visit series_path(@series)

			expect(page).to have_text(comic.redemption_code)
			#I'm not sure if I trust this one either... 
		end

	end

	context "when a series does not have comics" do

		before do 
			visit series_path(@series)
		end

		it "does not show a list of comics" do 
			expect(page).to have_text("Add a New Comic")

			expect(page).not_to have_text("Issue #")
			expect(page).not_to have_text("Redeem")
		end

		it "shows a link to add a new comic" do 
			click_link "Add a New Comic"

			expect(current_path).to eq(new_series_comic_path(@series))
		end

	end

end