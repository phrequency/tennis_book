require 'json'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

a = Mechanize.new

# first_name = "Lexi"
# last_name = "Bari"

# page = a.get("https://tennislink.usta.com/Tournaments/Rankings/RankingHome.aspx?FirstName=#{first_name}&MiddleName=&LastName=#{last_name}&Type=Ranking&Year=")

# puts id = page.search("//span[@id='ctl00_mainContent_grdMain_ctl02_lblPlayerName']/a").attr('href').to_s.split("PlayerId=").last.split("%3d")[0]

id = 'vaqU0QjquH2q3ZQDYplthQ'

url = "https://tennislink.usta.com/Tournaments/Rankings/RankingHome.aspx?"

params = {
	"FirstName" => "lexi",
	"LastName" => "bari",
	"Type" => "Ranking",
	"__EVENTTARGET" => "ctl00_mainContent_PlayerRecord_UpdatePanel",
	"__EVENTARGUMENT" => "Sender=lbtViewPlayerRecords&StartDt=3/1/2007&EndDt=3/16/2014&PlayerID=#{id}=="
}

headers = {
	"Accept" => "*/*",
	"Accept-Encoding" => "gzip,deflate,sdch",
	"Accept-Language" => "en-US,en;q=0.8,da;q=0.6,es;q=0.4,fi;q=0.2",
	"Cache-Control" => "no-cache",
	"Connection" => "keep-alive",
	"Cookie" => "ASP.NET_SessionId=abaauhq15b1atuc02vamne40; __qca=P0-635349534-1394991767304; SearchCondition=Team_Year=2014&Team_ProgramType=1&Team_ID=&Team_TeamNam=&Team_TeamNumber=&Team_MatchNumber=&City=&Champ_Section=&Champ_District=&Champ_Area=&Champ_Program=&Team_Section=-1&Champ_Level=-1&Team_FirstName=lexi&Team_LastName=bari&SearchType=SearchStatsAndStandings; ClassicUI=false; BigIPCookie=3608442634.47873.0000; __utma=248698626.1240417725.1394991767.1394991767.1394991767.1; __utmb=248698626.28.10.1394991767; __utmc=248698626; __utmz=248698626.1394991767.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); s_sess=%20s_cc%3Dtrue%3B%20SC_LINKS%3Dtlink%253Atourn%253Afind%2520a%2520ranking%253Aplayer%2520rankings%255E%255EBari%252C%2520Lexi%255E%255Etlink%253Atourn%253Afind%2520a%2520ranking%253Aplayer%2520rankings%2520%257C%2520Bari%252C%2520Lexi%255E%255E%3B%20s_sq%3Dustatennislinkprod%252Canustatennislinkprod%253D%252526pid%25253Dtlink%2525253Atourn%2525253Afind%25252520a%25252520ranking%2525253Aplayer%25252520rankings%252526pidt%25253D1%252526oid%25253Djavascript%2525253A__doPostBack%25252528%25252522ctl00_mainContent_PlayerRecord_UpdatePanel%25252522%2525252C%25252520%25252522Sender%2525253DlbtViewPlayerRecords%25252526S%252526ot%25253DA%3B",
	"Host" => "tennislink.usta.com",
	"Origin" => "https://tennislink.usta.com",
	"X-Requested-With" => "XMLHttpRequest"
}

page = a.post(url, params, headers)

#puts info_row = page.search("//div[@class='player_specs']")

page.search("//div[@class='CommonTable top-margin']").each do |table|
	t_name = table.css("span.event_title/text()").to_s.gsub(/^$\n/, '').strip
	# t_link = table.css("span.event_title/text()").to_s.gsub(/^$\n/, '')
	# t_id = table.css("span.event_title/a").to_s.split('ViewDraw(').last.split(',').first
	# t_link = "http://tennislink.usta.com/Tournaments/TournamentHome/Tournament.aspx?T=" + t_id
	rows = table.xpath("//tbody/tr")
	details = rows.collect do |row|
		detail = {}
		[
			[:opponent, 'td[3]/a/text()'],
			[:opponent_usta_id, 'td[3]/a'],
			[:result, 'td[2]/text()'],
			[:score, 'td[4]/text()']
		].each do |name, xpath|
			detail[name] = row.at_xpath(xpath).to_s.strip
		end
		detail
	end
	puts details.count
	# details.each do |d|
	# 	puts d[:opponent]
	# end
end



# page.search("//div[@class='CommonTable top-margin']").each do |table|
# 	rows = table.xpath("//tbody/tr")
# 	details = rows.collect do |row|
# 		detail = {}
# 		[
# 			[:opponent, 'td[3]/a/text()'],
# 			[:opponent_usta_id, 'td[3]/a'],
# 			[:result, 'td[2]/text()'],
# 			[:score, 'td[4]/text()']
# 		].each do |name, xpath|
# 			detail[name] = row.at_xpath(xpath).to_s.strip
# 		end
# 		detail
# 	end
# 	details.each do |d|
# 		puts d[:opponent]
# 	end
# 	# table.xpath("//tbody/tr").each_with_index do |row, index|
# 	# 	unless index == 0
# 	# 		row.css('td').each_with_index do |data, index2| 
# 	# 			if index2 == 0 && data.content != "Round"
# 	# 				round = data.content
# 	# 			elsif index2 == 1 && data.content != "Result"
# 	# 				puts result = data.content
# 	# 			elsif index2 == 2 && data.content != "Opponent"
# 	# 				opponent = data.content
# 	# 				if opponent_link = data.css("a").first
# 	# 					opponent_usta_id = data.css("a").first["href"].split("PlayerID=").last.split('")').first
# 	# 				end
# 	# 			elsif index2 == 3 && data.content != "Score"
# 	# 				score = data.content
# 	# 			end
# 	# 		end
# 	# 	end
# 	# end
# end