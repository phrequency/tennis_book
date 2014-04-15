class UsersController < ApplicationController
	before_filter :authenticate_user!

	require 'json'
	require 'nokogiri'
	require 'open-uri'
	require 'mechanize'

	def dash
		@user = current_user
	end

	def results
		@user = current_user
		@matches = @user.player.all_matches
	end


	def search_opponent
		opp_first_name = params[:first_name].downcase.strip
		opp_last_name = params[:last_name].downcase.strip
		redirect_to opponent_results_path(opp_name: opp_first_name + "_" + opp_last_name)
	end

	def opponent_results
		@user = current_user
		opp_first_name = params[:opp_name].split('_').first
		opp_last_name = params[:opp_name].split('_').last
		if opp_first_name && opp_last_name
			opp_search_name = opp_last_name + ", " + opp_first_name
			@opponent = Player.where(:name => opp_search_name).first
			if @opponent
				@own_matches = @opponent.own_matches
				@other_matches = @opponent.other_matches
				@matches_against_me = @opponent.all_matches.where('player1_id = :player_id OR player2_id = :player_id', player_id: current_user.player.id)
			end
		end
	end


	# def get_usta_data
	# 	unless current_user.player
	# 	 if params["first_name"] && params["last_name"]
	# 		a = Mechanize.new
	# 		first_name = params["first_name"].to_s
	# 		last_name = params["last_name"].to_s

	# 		page = a.get("https://tennislink.usta.com/Tournaments/Rankings/RankingHome.aspx?FirstName=#{first_name}&MiddleName=&LastName=#{last_name}&Type=Ranking&Year=")

	# 		id = page.search("//span[@id='ctl00_mainContent_grdMain_ctl02_lblPlayerName']/a").attr('href').to_s.split("PlayerId=").last.split("%3d")[0]

	# 		unless Player.where(:usta_id => id, :user_id => current_user.id).first
	# 			Player.create(:usta_id => id, :user_id => current_user.id, :name => last_name.capitalize + ', ' + first_name.capitalize)
	# 		end

	# 		url = "https://tennislink.usta.com/Tournaments/Rankings/RankingHome.aspx?"

	# 		params = {
	# 			"FirstName" => "lexi",
	# 			"LastName" => "bari",
	# 			"Type" => "Ranking",
	# 			"__EVENTTARGET" => "ctl00_mainContent_PlayerRecord_UpdatePanel",
	# 			"__EVENTARGUMENT" => "Sender=lbtViewPlayerRecords&StartDt=8/1/2013&EndDt=3/16/2014&PlayerID=#{id}=="
	# 		}

	# 		headers = {
	# 			"Accept" => "*/*",
	# 			"Accept-Encoding" => "gzip,deflate,sdch",
	# 			"Accept-Language" => "en-US,en;q=0.8,da;q=0.6,es;q=0.4,fi;q=0.2",
	# 			"Cache-Control" => "no-cache",
	# 			"Connection" => "keep-alive",
	# 			"Cookie" => "ASP.NET_SessionId=abaauhq15b1atuc02vamne40; __qca=P0-635349534-1394991767304; SearchCondition=Team_Year=2014&Team_ProgramType=1&Team_ID=&Team_TeamNam=&Team_TeamNumber=&Team_MatchNumber=&City=&Champ_Section=&Champ_District=&Champ_Area=&Champ_Program=&Team_Section=-1&Champ_Level=-1&Team_FirstName=lexi&Team_LastName=bari&SearchType=SearchStatsAndStandings; ClassicUI=false; BigIPCookie=3608442634.47873.0000; __utma=248698626.1240417725.1394991767.1394991767.1394991767.1; __utmb=248698626.28.10.1394991767; __utmc=248698626; __utmz=248698626.1394991767.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); s_sess=%20s_cc%3Dtrue%3B%20SC_LINKS%3Dtlink%253Atourn%253Afind%2520a%2520ranking%253Aplayer%2520rankings%255E%255EBari%252C%2520Lexi%255E%255Etlink%253Atourn%253Afind%2520a%2520ranking%253Aplayer%2520rankings%2520%257C%2520Bari%252C%2520Lexi%255E%255E%3B%20s_sq%3Dustatennislinkprod%252Canustatennislinkprod%253D%252526pid%25253Dtlink%2525253Atourn%2525253Afind%25252520a%25252520ranking%2525253Aplayer%25252520rankings%252526pidt%25253D1%252526oid%25253Djavascript%2525253A__doPostBack%25252528%25252522ctl00_mainContent_PlayerRecord_UpdatePanel%25252522%2525252C%25252520%25252522Sender%2525253DlbtViewPlayerRecords%25252526S%252526ot%25253DA%3B",
	# 			"Host" => "tennislink.usta.com",
	# 			"Origin" => "https://tennislink.usta.com",
	# 			"X-Requested-With" => "XMLHttpRequest"
	# 		}

	# 		page = a.post(url, params, headers)

	# 		page.search("//div[@class='CommonTable top-margin']").each do |table|
	# 			rows = table.xpath("//tbody/tr")
	# 			details = rows.collect do |row|
	# 				detail = {}
	# 				[
	# 					[:opponent, 'td[3]/a/text()'],
	# 					[:opponent_usta_id, 'td[3]/a'],
	# 					[:result, 'td[2]/text()'],
	# 					[:score, 'td[4]/text()']
	# 				].each do |name, xpath|
	# 					detail[name] = row.at_xpath(xpath).to_s.strip
	# 				end
	# 				detail
	# 			end
	# 			details.each do |d|
	# 				if d
	# 					unless d[:opponent] == ""
	# 						opponent_usta_id = d[:opponent_usta_id].split("PlayerID=").last.split('")').first
	# 						unless player = Player.where(:usta_id => opponent_usta_id).first
	# 							player = Player.create(:usta_id => opponent_usta_id, :name => d[:opponent])
	# 						end
	# 						unless Match.where(:player1_id => current_user.player.id, :player2_id => player.id, :result => d[:result], :score => d[:score]).first
	# 							Match.create(:player1_id => current_user.player.id, :player2_id => player.id, :result => d[:result], :score => d[:score])
	# 						end
	# 					end
	# 				end
	# 			end
	# 		end
	# 	 end
	# 	end
	# 	redirect_to results_path
	# end


end
