class Player < ActiveRecord::Base
  attr_accessible :name, :user_id, :usta_id, :location, :overall_record, :date_range, :image, :birthday, :gender, :parent_email

  belongs_to :user

  has_many :own_matches, foreign_key: "player1_id", class_name: "Match"
  has_many :other_matches, foreign_key: "player2_id", class_name: "Match"

  mount_uploader :image, ImageUploader

  def real_name
    self.name.split(", ").last.capitalize + " " + self.name.split(", ").first.capitalize
  end

  def age
    now = Time.now.utc.to_date
    dob = self.birthday
    years = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    months = now.month - dob.month
    years.to_s + " years and " + months.to_s + " months"
  end


  def is_registered
  	if self.user
  		return true
  	end 	
  end

  def all_matches
	Match.where('player1_id = :player_id OR player2_id = :player_id', player_id: self.id)
  end

  def get_other_player_info
      a = Mechanize.new

      id = self.usta_id

      url = "https://tennislink.usta.com/Tournaments/Rankings/RankingHome.aspx?"

      params = {
        "FirstName" => "lexi",
        "LastName" => "bari",
        "Type" => "Ranking",
        "__EVENTTARGET" => "ctl00_mainContent_PlayerRecord_UpdatePanel",
        "__EVENTARGUMENT" => "Sender=lbtViewPlayerRecords&StartDt=8/1/2010&EndDt=3/16/2014&PlayerID=#{id}=="
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

      info_row = page.search("//div[@class='player_specs']/table/tr")[1]
      if info_row
        info_detail = {}
          [
            [:date_range, 'td[2]/text()'],
            [:overall_record, 'td[3]/text()'],
            [:location, 'td[4]/text()']
          ].each do |name, xpath|
            info_detail[name] = info_row.at_xpath(xpath).to_s.strip
          end
        self.date_range = info_detail[:date_range]
        self.overall_record = info_detail[:overall_record]
        self.location = info_detail[:location]
        self.save
      end
  end

  handle_asynchronously :get_other_player_info

end
