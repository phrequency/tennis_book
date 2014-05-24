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
		@players_i_played = Player.find_all_by_id(@user.active_player.own_matches.sort.map(&:player2_id))
		@players_played_me = Player.find_all_by_id(@user.active_player.other_matches.sort.map(&:player1_id))
	end

	def my_friends
		@user = current_user

		@people_friended_you_ids = @user.inverse_friendships.where('user_id NOT IN (:fr) OR (:fr) IS NULL', fr: @user.friendships.map(&:friend_id)).map(&:user_id)
		@people_you_friended_ids = @user.friendships.where('friend_id NOT IN (:inv) OR (:inv) IS NULL', inv: @user.inverse_friendships.map(&:user_id)).map(&:friend_id)
		@your_friends_ids = @user.friendships.where('friend_id IN (:inv)', inv: @user.inverse_friendships.map(&:user_id)).map(&:friend_id)



		@people_friended_you = User.find_all_by_id(@people_friended_you_ids)
		@people_you_friended = User.find_all_by_id(@people_you_friended_ids)
		@your_friends = User.find_all_by_id(@your_friends_ids)
	end


	def search_opponent
		opp_first_name = params[:first_name].downcase.strip
		opp_last_name = params[:last_name].downcase.strip
		redirect_to narrow_results_path(opp_name: opp_first_name + "_" + opp_last_name)
	end

	def narrow_results
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
		@opponent = Player.find(params[:id])
			if @opponent
				@own_matches_against_me = @opponent.all_matches.where('player2_id = :player_id', player_id: @user.active_player.id)
				@other_matches_against_me = @opponent.all_matches.where('player1_id = :player_id', player_id: @user.active_player.id)
				
				@my_friendships = @user.friends
				@my_friend_ids = []
				@my_friendships.each do |friendship|
					if @user.is_a_friend(friendship)
						@my_friend_ids << friendship.id 
					end
				end

				@friend_own_matches = @opponent.all_matches.where('player1_id IN (:players) AND player2_id = :opponent_id', opponent_id: @opponent.id, players: @my_friend_ids)
				@friend_other_matches = @opponent.all_matches.where('player1_id = :opponent_id AND player2_id IN (:players)', opponent_id: @opponent.id, players: @my_friend_ids)

				@my_opponent_ids_other = Player.find_all_by_id(@user.active_player.other_matches.map(&:player1_id)).map(&:id)
				@my_opponent_ids_own = Player.find_all_by_id(@user.active_player.own_matches.map(&:player2_id)).map(&:id)

				if @my_opponent_ids_own && @my_friend_ids
					@my_opponent_ids_own = @my_opponent_ids_own - @my_friend_ids
				end

				if @my_opponent_ids_other && @my_friend_ids
					@my_opponent_ids_other = @my_opponent_ids_other - @my_friend_ids
				end

				@opponent_matches_other = Match.where('player1_id = :opponent_id AND player2_id IN (:players)', opponent_id: @opponent.id, players: @my_opponent_ids_other)
				@opponent_matches_own = Match.where('player1_id IN (:players) AND player2_id = :opponent_id', opponent_id: @opponent.id, players: @my_opponent_ids_own)
			end
	end

	def profile
		@user = current_user
		@player = @user.active_player
	end

	def add_new_player
		@user = current_user
		@user.add_this_player(params[:first_name], params[:last_name])
		flash[:notice] = "Adding new player. This might take a while! Refresh this page in a few minutes"
		redirect_to dash_path
	end


end
