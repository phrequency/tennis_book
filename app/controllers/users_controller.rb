class UsersController < ApplicationController
	before_filter :authenticate_user!

	require 'json'
	require 'nokogiri'
	require 'open-uri'
	require 'mechanize'
	require 'aws-sdk'

	def dash
		@user = current_user
	end

	def switch_accounts
		@user = current_user
		@user.accounts.each do |a|
            a.active = "false"
            a.save
          end
        account = Account.find(params["id"])
        account.active = "true"
        account.save
		redirect_to dash_path
	end


	def results
		@user = current_user
		@player = current_user.active_player
		@players_i_played = Player.find_all_by_id(@user.active_player.own_matches.sort.map(&:player2_id)).sort_by(&:name)
		@players_played_me = Player.find_all_by_id(@user.active_player.other_matches.sort.map(&:player1_id)).sort_by(&:name)

		@specials = ['Def', 'Ret', 'Wo', 'Wd', 'WD']
	end

	def results_by_date
		@user = current_user
		@player = current_user.active_player
		@own_matches = @user.active_player.own_matches
		@other_matches = @user.active_player.other_matches
		@all_my_matches = (@own_matches + @other_matches).sort#_by{|h| h[:real_datetime]}

		@specials = ['Def', 'Ret', 'Wo', 'Wd', 'WD']
	end

	def my_friends
		@user = current_user
		@player = current_user.active_player

		@people_friended_you_ids = @player.inverse_friendships.where('player_id NOT IN (:fr) OR (:fr) IS NULL', fr: @player.friendships.map(&:friend_id)).map(&:player_id)
		@people_you_friended_ids = @player.friendships.where('friend_id NOT IN (:inv) OR (:inv) IS NULL', inv: @player.inverse_friendships.map(&:player_id)).map(&:friend_id)
		@your_friends_ids = @player.friendships.where('friend_id IN (:inv)', inv: @player.inverse_friendships.map(&:player_id)).map(&:friend_id)

		@people_friended_you = Player.find_all_by_id(@people_friended_you_ids)
		@people_you_friended = Player.find_all_by_id(@people_you_friended_ids)
		@your_friends = Player.find_all_by_id(@your_friends_ids)
	end


	def search_opponent
		@user = current_user
		opp_first_name = params[:first_name].downcase.strip
		opp_last_name = params[:last_name].downcase.strip
		redirect_to narrow_results_path(opp_name: opp_first_name + "_" + opp_last_name)
	end

	def narrow_results
		@user = current_user
		if params[:opp_name]
			opp_first_name = params[:opp_name].split('_').first
			opp_last_name = params[:opp_name].split('_').last
			if opp_first_name && opp_last_name
				opp_search_name = opp_last_name + ", " + opp_first_name
				@results = Player.where(:name => opp_search_name)
			end
		end
	end

	def opponent_results
		@user = current_user
		@player = @user.active_player
		@specials = ['Def', 'Ret', 'Wo', 'Wd', 'WD']
		@opponent = Player.find(params[:id])
			if @opponent
				@own_matches_against_me = @opponent.all_matches.where('player2_id = :player_id', player_id: @player.id)
				@other_matches_against_me = @opponent.all_matches.where('player1_id = :player_id', player_id: @player.id)
				
				@my_friendships = @player.friends
				@my_friend_ids = []
				@my_friendships.each do |friendship|
					if @player.is_a_friend(friendship)
						@my_friend_ids << friendship.id 
					end
				end

				@friend_own_matches = @opponent.all_matches.where('player1_id IN (:players) AND player2_id = :opponent_id', opponent_id: @opponent.id, players: @my_friend_ids)
				@friend_other_matches = @opponent.all_matches.where('player1_id = :opponent_id AND player2_id IN (:players)', opponent_id: @opponent.id, players: @my_friend_ids)

				@my_opponent_ids_other = @player.other_matches.map(&:player1_id)
				@my_opponent_ids_own = @player.own_matches.map(&:player2_id)
				@all_my_opponent_ids = @my_opponent_ids_other + @my_opponent_ids_own

				@people_ive_played = @all_my_opponent_ids - @my_friend_ids

				@opponent_matches_other = @opponent.own_matches.where('player2_id IN (:players)', players: @people_ive_played)
				@opponent_matches_own = @opponent.other_matches.where('player1_id IN (:players)', players: @people_ive_played)

			end
	end

	def profile
		@user = current_user
		@player = @user.active_player
	end

	def step2
		@user = current_user
		@player = @user.active_player
	end

	def add_new_player
		@user = current_user
		if params[:usta_id] && params[:usta_id].length == 10
			@user.add_this_player(params[:first_name], params[:last_name], params[:usta_id])
			flash[:notice] = "Adding new player. This might take a while! Refresh this page in a few minutes"
			redirect_to dash_path
		else
			flash[:notice] = "Please enter a correct USTA ID"
			redirect_to dash_path
		end
	end

	def destroy_old
		current_user.destroy
		if current_user.destroy
			flash[:notice] = "Please sign up again with the correct USTA ID"
			redirect_to new_user_registration_path
		end
	end


end
